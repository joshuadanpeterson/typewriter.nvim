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
local logger = require("typewriter.logger")

local M = {}
local typewriter_active = false

--- Restore the cursor to its original position
---
--- `start_row` is zero-based, matching Neovim's API. We therefore add no
--- extra offset when calculating the final cursor row.
local function restore_cursor(start_row, cursor_row, cursor_col)
        vim.schedule(function()
                vim.api.nvim_win_set_cursor(0, { start_row + cursor_row, cursor_col })
        end)
end

--- Helper function to determine if a node is a significant block
local function is_significant_block(node)
	local node_type = node:type()
	return center_block_config.should_expand(node_type)
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
        -- Determine if the cursor is at the edge of the file so gg and G work
        -- without forcing the view to center.
        local line = cursor[1]
        local last_line = api.nvim_buf_line_count(0)

        -- Determine if always_center is active globally or for this filetype
        local cfg = config.get_config()
        local ft = vim.bo.filetype
        local force_center = cfg.always_center or cfg.always_center_filetypes[ft]

        if line == 1 then
                api.nvim_command("normal! zt")
        elseif line == last_line and not force_center then
                api.nvim_command("normal! zb")
        else
                api.nvim_command("normal! zz")
        end

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
                logger.info("Typewriter mode enabled")
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
                api.nvim_win_set_option(0, "wrap", true)
		--- Restore the original horizontal position
                vim.fn.winrestview({ leftcol = 0 })
		--- Notify the user that typewriter mode is disabled
                utils.notify("Typewriter mode disabled")
                logger.info("Typewriter mode disabled")
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
--- Center the current code block and cursor
function M.center_block_and_cursor()
	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	node = get_expand_root(node)
	if not node then
		return
	end

       -- start_row is zero-based as returned by Treesitter's range()
       local start_row, _, end_row, _ = node:range()
	local middle_line = math.floor((start_row + end_row) / 2)

	-- Check for edge cases
	local line_count = vim.api.nvim_buf_line_count(0)
	if middle_line < 0 then middle_line = 0 end
	if middle_line >= line_count then middle_line = line_count - 1 end

	-- Determine the visible window range
	local win_height = vim.api.nvim_win_get_height(0)
	local top_visible_line = math.max(middle_line - math.floor(win_height / 2), 0)
	local bottom_visible_line = math.min(middle_line + math.floor(win_height / 2), line_count - 1)

	if config.config.keep_cursor_position then
		local cursor = vim.api.nvim_win_get_cursor(0)
		-- Save current cursor position
		local cursor_row = cursor[1]
		local cursor_col = cursor[2]

		-- Move cursor to the middle line of the block and center the view
		vim.cmd(string.format("normal! %dGzz", middle_line + 1))

		-- Restore original cursor position
		vim.api.nvim_win_set_cursor(0, { cursor_row, cursor_col })
	else
		-- Move cursor to the middle line of the block and center the view
		vim.cmd(string.format("normal! %dGzz", middle_line + 1))
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

       -- start_row is zero-based as returned by Treesitter's range()
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
               restore_cursor(start_row, cursor_row, cursor_col)
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
               restore_cursor(start_row, cursor_row, cursor_col)
       end

	utils.notify("Code block aligned with the bottom")
end

return M
