-- lua/typewriter/init.lua
-- This plugin provides typewriter scrolling for neovim.

local api = vim.api
local ts_utils = require("nvim-treesitter.ts_utils")
local center_block_config = require("typewriter.utils.center_block_config")

local M = {}

M.config = {
	enable_with_zen_mode = true,
	enable_with_true_zen = true,
	keep_cursor_position = true,
	enable_notifications = true, -- New config option
}

local typewriter_active = false

local function notify(message)
	if M.config.enable_notifications then
		vim.notify(message, vim.log.levels.INFO)
	end
end

local function center_cursor()
	if not typewriter_active then
		return
	end
	-- Get the current cursor position
	local cursor = api.nvim_win_get_cursor(0)
	-- Center the screen around the cursor
	api.nvim_command("normal! zz")
	-- Restore the cursor position
	api.nvim_win_set_cursor(0, cursor)
end

local function enable_typewriter_mode()
	if not typewriter_active then
		typewriter_active = true
		-- Set autocommands for normal, insert, and visual modes
		api.nvim_command('autocmd CursorMoved,CursorMovedI * lua require("typewriter").center_cursor()')
		notify("Typewriter mode enabled")
	end
end

local function disable_typewriter_mode()
	if typewriter_active then
		typewriter_active = false
		-- Clear the autocommand group for TypewriterMode
		api.nvim_command("autocmd! TypewriterMode")
		notify("Typewriter mode disabled")
	end
end

local function toggle_typewriter_mode()
	if typewriter_active then
		disable_typewriter_mode()
	else
		enable_typewriter_mode()
	end
end

local function center_block_and_cursor()
	local function is_significant_block(node)
		local node_type = node:type()
		return center_block_config.expand[node_type] == true
	end

	local function get_expand_root(node)
		while node do
			if is_significant_block(node) then
				return node
			end
			node = node:parent()
		end
		return nil
	end

	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	-- Check if the initial node is significant
	node = get_expand_root(node)
	if not node then
		return
	end

	-- Get the range of the block/function
	local start_row, _, end_row, _ = node:range()

	-- Calculate the middle line of the block/function
	local middle_line = math.floor((start_row + end_row) / 2)

	-- Center the view around the middle line without moving the cursor
	if M.config.keep_cursor_position then
		local cursor = api.nvim_win_get_cursor(0)
		vim.cmd("normal! zz")
		api.nvim_win_set_cursor(0, cursor)
	else
		vim.cmd("normal! zz")
	end

	notify("Code block centered")
end

local function move_to_top_of_block()
	local function is_significant_block(node)
		local node_type = node:type()
		return center_block_config.expand[node_type] == true
	end

	local function get_expand_root(node)
		while node do
			if is_significant_block(node) then
				return node
			end
			node = node:parent()
		end
		return nil
	end

	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	-- Check if the initial node is significant
	node = get_expand_root(node)
	if not node then
		return
	end

	-- Get the range of the block/function
	local start_row, _, _, _ = node:range()

	local cursor_row, cursor_col
	if M.config.keep_cursor_position then
		-- Save the current cursor position relative to the block
		local cursor = api.nvim_win_get_cursor(0)
		cursor_row = cursor[1] - start_row
		cursor_col = cursor[2]
	end

	-- Move the cursor to the start of the block
	vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
	-- Scroll so that the top of the block is at the top of the window
	vim.cmd("normal! zt")

	if M.config.keep_cursor_position then
		-- Restore the cursor position relative to the text
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(0, { start_row + 1 + cursor_row, cursor_col })
		end)
	end

	notify("Code block aligned with the top")
end

local function move_to_bottom_of_block()
	local function is_significant_block(node)
		local node_type = node:type()
		return center_block_config.expand[node_type] == true
	end

	local function get_expand_root(node)
		while node do
			if is_significant_block(node) then
				return node
			end
			node = node:parent()
		end
		return nil
	end

	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	-- Check if the initial node is significant
	node = get_expand_root(node)
	if not node then
		return
	end

	-- Get the range of the block/function
	local start_row, _, end_row, _ = node:range()

	local cursor_row, cursor_col
	if M.config.keep_cursor_position then
		-- Save the current cursor position relative to the block
		local cursor = api.nvim_win_get_cursor(0)
		cursor_row = cursor[1] - start_row
		cursor_col = cursor[2]
	end

	-- Move the cursor to the end of the block
	vim.api.nvim_win_set_cursor(0, { end_row + 1, 0 })
	-- Scroll so that the bottom of the block is at the bottom of the window
	vim.cmd("normal! zb")

	if M.config.keep_cursor_position then
		-- Restore the cursor position relative to the text
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(0, { start_row + 1 + cursor_row, cursor_col })
		end)
	end

	notify("Code block aligned with the bottom")
end

local function setup(user_config)
	user_config = user_config or {}
	if type(user_config) == "table" then
		M.config = vim.tbl_extend("force", M.config, user_config)
	end
	api.nvim_command("augroup TypewriterMode")
	api.nvim_command("autocmd!")
	api.nvim_command("augroup END")
	api.nvim_create_user_command("TWEnable", enable_typewriter_mode, {})
	api.nvim_create_user_command("TWDisable", disable_typewriter_mode, {})
	api.nvim_create_user_command("TWToggle", toggle_typewriter_mode, {})
	api.nvim_create_user_command("TWCenter", center_block_and_cursor, {})
	api.nvim_create_user_command("TWTop", move_to_top_of_block, {})
	api.nvim_create_user_command("TWBottom", move_to_bottom_of_block, {})
	if M.config.enable_with_zen_mode then
		api.nvim_command('autocmd User ZenModePre lua require("typewriter").enable()')
		api.nvim_command('autocmd User ZenModeLeave lua require("typewriter").disable()')
	end
	if M.config.enable_with_true_zen then
		api.nvim_command('autocmd User TZWoon lua require("typewriter").enable()')
		api.nvim_command('autocmd User TZOff lua require("typewriter").disable()')
	end
end

M.setup = setup
M.center_cursor = center_cursor
M.enable = enable_typewriter_mode
M.disable = disable_typewriter_mode
M.toggle = toggle_typewriter_mode
M.center_block_and_cursor = center_block_and_cursor
M.move_to_top_of_block = move_to_top_of_block
M.move_to_bottom_of_block = move_to_bottom_of_block

return M
