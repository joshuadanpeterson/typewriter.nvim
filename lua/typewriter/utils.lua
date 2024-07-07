--- Utility functions for Typewriter.nvim
---
--- This module contains utility functions used in Typewriter.nvim.
---
--- @module typewriter.utils
--- @file lua/typewriter/utils.lua
--- @tag typewriter-utils

local config = require("typewriter.config")

local M = {}

--- Notify the user with a message if notifications are enabled
---
--- @param message string: The message to display
function M.notify(message)
	if config.config.enable_notifications then
		vim.notify(message, vim.log.levels.INFO)
	end
end

--- Center the cursor horizontally if horizontal scrolling is enabled
function M.center_cursor_horizontally()
	if not config.config.enable_horizontal_scroll then
		return
	end
	local win_width = vim.api.nvim_win_get_width(0)
	local cursor_col = vim.fn.virtcol(".")
	local left_col = math.max(cursor_col - math.floor(win_width / 2), 0) + 10
	vim.api.nvim_win_set_option(0, "wrap", false)
	vim.fn.winrestview({ leftcol = left_col })
end

return M
