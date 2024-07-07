--- Commands for Typewriter.nvim functionality
--- @module typewriter.commands
--- @file lua/typewriter/commands.lua

local api = vim.api
local ts_utils = require("nvim-treesitter.ts_utils")
local utils = require("typewriter.utils")
local config = require("typewriter.config")
local center_block_config = require("typewriter.utils.center_block_config")

local M = {}
local typewriter_active = false

--- Center the cursor on the screen
function M.center_cursor()
	if not typewriter_active then
		return
	end
	local cursor = api.nvim_win_get_cursor(0)
	api.nvim_command("normal! zz")
	api.nvim_win_set_cursor(0, cursor)
end

--- Enable typewriter mode
function M.enable_typewriter_mode()
	if not typewriter_active then
		typewriter_active = true
		api.nvim_command("augroup TypewriterMode")
		api.nvim_command("autocmd!")
		api.nvim_command('autocmd CursorMoved,CursorMovedI * lua require("typewriter.commands").center_cursor()')
		api.nvim_command(
			'autocmd CursorMoved,CursorMovedI * lua require("typewriter.utils").center_cursor_horizontally()'
		)
		api.nvim_command("augroup END")
		utils.notify("Typewriter mode enabled")
	end
end

--- Disable typewriter mode
function M.disable_typewriter_mode()
	if typewriter_active then
		typewriter_active = false
		api.nvim_command("augroup TypewriterMode")
		api.nvim_command("autocmd!")
		api.nvim_command("augroup END")
		utils.notify("Typewriter mode disabled")
	end
end

--- Toggle typewriter mode
function M.toggle_typewriter_mode()
	if typewriter_active then
		M.disable_typewriter_mode()
	else
		M.enable_typewriter_mode()
	end
end

--- Center the current code block and cursor
function M.center_block_and_cursor()
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

	node = get_expand_root(node)
	if not node then
		return
	end

	local start_row, _, end_row, _ = node:range()
	local middle_line = math.floor((start_row + end_row) / 2)

	if config.config.keep_cursor_position then
		local cursor = api.nvim_win_get_cursor(0)
		vim.cmd("normal! zz")
		api.nvim_win_set_cursor(0, cursor)
	else
		vim.cmd("normal! zz")
	end

	utils.notify("Code block centered")
end

--- Move the top of the current code block to the top of the screen
function M.move_to_top_of_block()
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

	node = get_expand_root(node)
	if not node then
		return
	end

	local start_row, _, _, _ = node:range()

	local cursor_row, cursor_col
	if config.config.keep_cursor_position then
		local cursor = api.nvim_win_get_cursor(0)
		cursor_row = cursor[1] - start_row
		cursor_col = cursor[2]
	end

	vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
	vim.cmd("normal! zt")

	if config.config.keep_cursor_position then
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(0, { start_row + 1 + cursor_row, cursor_col })
		end)
	end

	utils.notify("Code block aligned with the top")
end

--- Move the bottom of the current code block to the bottom of the screen
function M.move_to_bottom_of_block()
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

	node = get_expand_root(node)
	if not node then
		return
	end

	local start_row, _, end_row, _ = node:range()

	local cursor_row, cursor_col
	if config.config.keep_cursor_position then
		local cursor = api.nvim_win_get_cursor(0)
		cursor_row = cursor[1] - start_row
		cursor_col = cursor[2]
	end

	vim.api.nvim_win_set_cursor(0, { end_row + 1, 0 })
	vim.cmd("normal! zb")

	if config.config.keep_cursor_position then
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(0, { start_row + 1 + cursor_row, cursor_col })
		end)
	end

	utils.notify("Code block aligned with the bottom")
end

M.center_block_and_cursor = center_block_and_cursor
M.move_to_top_of_block = move_to_top_of_block
M.move_to_bottom_of_block = move_to_bottom_of_block

return M
