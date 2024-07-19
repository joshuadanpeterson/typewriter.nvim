--- Commands for Typewriter.nvim functionality
---
--- This module provides the core functionality for Typewriter.nvim,
--- including cursor centering, typewriter mode toggling, and block navigation.
---
--- @module typewriter.commands
--- @file lua/typewriter/commands.lua
--- @tag typewriter-commands

local api = vim.api
local ts_utils = require("nvim-treesitter.ts_utils")
local utils = require("typewriter.utils")
local config = require("typewriter.config")
local center_block_config = require("typewriter.utils.center_block_config")

local M = {}
local typewriter_active = false

--- Helper function to determine if a node is a significant block
local function is_significant_block(node)
	local node_type = node:type()
	return center_block_config.expand[node_type] == true
end

--- Helper function to get the root of the expandable block
local function get_expand_root(node)
	while node do
		if is_significant_block(node) then
			return node
		end
		node = node:parent()
	end
	return nil
end

--- Center the cursor on the screen
---
--- This function moves the view so that the cursor is centered vertically
--- on the screen. It's the core of the typewriter-style scrolling.
---
--- @usage require("typewriter.commands").center_cursor()
function M.center_cursor()
	if not utils.is_typewriter_active() then
		return
	end
	local cursor = api.nvim_win_get_cursor(0)
	api.nvim_command("normal! zz")
	api.nvim_win_set_cursor(0, cursor)
end

--- Enable typewriter mode
---
--- Activates the typewriter mode, which keeps the cursor centered
--- on the screen as you type or move through the document.
---
--- @usage require("typewriter.commands").enable_typewriter_mode()
function M.enable_typewriter_mode()
	if not utils.is_typewriter_active() then
		utils.set_typewriter_active(true)
		api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = api.nvim_create_augroup("TypewriterMode", { clear = true }),
			callback = function()
				M.center_cursor()
				utils.center_cursor_horizontally()
			end,
		})
		utils.notify("Typewriter mode enabled")
	end
end

--- Disable typewriter mode
---
--- Deactivates the typewriter mode, returning to normal scrolling behavior.
---
--- @usage require("typewriter.commands").disable_typewriter_mode()
function M.disable_typewriter_mode()
	if utils.is_typewriter_active() then
		utils.set_typewriter_active(false)
		api.nvim_clear_autocmds({ group = "TypewriterMode" })
		utils.notify("Typewriter mode disabled")
	end
end

--- Toggle typewriter mode
---
--- Switches between enabled and disabled states of typewriter mode.
---
--- @usage require("typewriter.commands").toggle_typewriter_mode()
function M.toggle_typewriter_mode()
	if utils.is_typewriter_active() then
		M.disable_typewriter_mode()
	else
		M.enable_typewriter_mode()
	end
end

--- Center the current code block and cursor
---
--- This function centers both the current code block and the cursor on the screen.
--- It's useful for focusing on a specific block of code.
---
--- @usage require("typewriter.commands").center_block_and_cursor()
function M.center_block_and_cursor()
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

	-- Check for edge cases
	local line_count = api.nvim_buf_line_count(0)
	if middle_line < 0 then middle_line = 0 end
	if middle_line >= line_count then middle_line = line_count - 1 end

	if config.config.keep_cursor_position then
		local cursor = api.nvim_win_get_cursor(0)
		-- Save current cursor position
		local cursor_row = cursor[1]
		local cursor_col = cursor[2]

		-- Move cursor to the middle line of the block and center the view
		api.nvim_win_set_cursor(0, { middle_line + 1, 0 })
		vim.cmd("normal! zz")

		-- Adjust if the middle line is too close to the end of the file
		local new_cursor_row = math.min(cursor_row, line_count)
		api.nvim_win_set_cursor(0, { new_cursor_row, cursor_col })
	else
		-- Move cursor to the middle line of the block and center the view
		api.nvim_win_set_cursor(0, { middle_line + 1, 0 })
		vim.cmd("normal! zz")
	end

	utils.notify("Code block centered")
end

--- Move the top of the current code block to the top of the screen
---
--- This function aligns the top of the current code block with the top of the screen,
--- providing a clear view of the entire block.
---
--- @usage require("typewriter.commands").move_to_top_of_block()
function M.move_to_top_of_block()
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
---
--- This function aligns the bottom of the current code block with the bottom of the screen,
--- allowing you to see the end of the block and what follows it.
---
--- @usage require("typewriter.commands").move_to_bottom_of_block()
function M.move_to_bottom_of_block()
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

return M
