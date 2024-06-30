-- lua/typewriter/init.lua
-- This plugin provides typewriter scrolling for neovim.

local api = vim.api
local typewriter_active = false
local config = {
	enable_with_zen_mode = true,
	enable_with_true_zen = true,
	keep_cursor_position = true,
}

local function center_cursor()
	if not typewriter_active then
		return
	end
	-- Center the screen around the cursor without moving the cursor
	api.nvim_command("normal! zz")
end

local function enable_typewriter_mode()
	if not typewriter_active then
		typewriter_active = true
		-- Set autocommands for normal, insert, and visual modes
		api.nvim_command('autocmd CursorMoved,CursorMovedI * lua require("typewriter").center_cursor()')
		print("Typewriter mode enabled")
	end
end

local function disable_typewriter_mode()
	if typewriter_active then
		typewriter_active = false
		-- Clear the autocommand group for TypewriterMode
		api.nvim_command("autocmd! TypewriterMode")
		print("Typewriter mode disabled")
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
	local ts_utils = require("nvim-treesitter.ts_utils")
	local config = require("typewriter.utils.center_block_config")

	local function is_significant_block(node)
		local node_type = node:type()
		return config.expand[node_type] ~= nil
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
	vim.cmd("normal! zz")
end

local function move_to_top_of_block()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local config = require("typewriter.utils.center_block_config")

	local function is_significant_block(node)
		local node_type = node:type()
		return config.expand[node_type] ~= nil
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

	-- Move the cursor to the start of the block
	vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
	-- Scroll so that the top of the block is at the top of the window
	vim.cmd("normal! zt")
	-- Add offset to ensure the top line is visible
	vim.schedule(function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("1<C-y>", true, true, true), "n", true)
	end)
end

local function move_to_bottom_of_block()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local config = require("typewriter.utils.center_block_config")

	local function is_significant_block(node)
		local node_type = node:type()
		return config.expand[node_type] ~= nil
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
	local _, _, end_row, _ = node:range()

	-- Move the cursor to the end of the block
	vim.api.nvim_win_set_cursor(0, { end_row + 1, 0 })
	-- Scroll so that the bottom of the block is at the bottom of the window
	vim.cmd("normal! zb")
	-- Add offset to ensure the bottom line is visible
	vim.schedule(function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("1<C-e>", true, true, true), "n", true)
	end)
end

local function setup(user_config)
	user_config = user_config or {}
	if type(user_config) == "table" then
		config = vim.tbl_extend("force", config, user_config)
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
	if config.enable_with_zen_mode then
		api.nvim_command('autocmd User ZenModePre lua require("typewriter").enable()')
		api.nvim_command('autocmd User ZenModeLeave lua require("typewriter").disable()')
	end
	if config.enable_with_true_zen then
		api.nvim_command('autocmd User TZWoon lua require("typewriter").enable()')
		api.nvim_command('autocmd User TZOff lua require("typewriter").disable()')
	end
end

return {
	setup = setup,
	center_cursor = center_cursor,
	enable = enable_typewriter_mode,
	disable = disable_typewriter_mode,
	toggle = toggle_typewriter_mode,
	center_block_and_cursor = center_block_and_cursor,
	move_to_top_of_block = move_to_top_of_block,
	move_to_bottom_of_block = move_to_bottom_of_block,
}
