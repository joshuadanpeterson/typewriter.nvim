--- Utility functions for Typewriter.nvim
---
--- This module contains utility functions used throughout Typewriter.nvim.
--- It provides functionality for user notifications and horizontal cursor centering.
---
--- @module typewriter.utils
--- @file lua/typewriter/utils.lua
--- @tag typewriter-utils

local config = require("typewriter.config")

local M = {}

--- Notify the user with a message if notifications are enabled
---
--- This function displays a notification to the user using Neovim's built-in
--- notification system. The notification will only be shown if the
--- `enable_notifications` option is set to true in the plugin's configuration.
---
--- @param message string The message to display in the notification
--- @usage
--- local utils = require("typewriter.utils")
--- utils.notify("Typewriter mode enabled")
function M.notify(message)
	if config.config.enable_notifications then
		vim.notify(message, vim.log.levels.INFO, { title = "Typewriter.nvim" })
	end
end

--- Center the cursor horizontally if horizontal scrolling is enabled
---
--- This function centers the cursor horizontally in the window by adjusting
--- the view. It only takes effect if the `enable_horizontal_scroll` option
--- is set to true in the plugin's configuration. The function also disables
--- line wrapping to allow for horizontal scrolling.
---
--- @usage
--- local utils = require("typewriter.utils")
--- utils.center_cursor_horizontally()
function M.center_cursor_horizontally()
	if not config.config.enable_horizontal_scroll then
		return
	end

	-- Get the width of the current window
	local win_width = vim.api.nvim_win_get_width(0)

	-- Get the current cursor column (in virtual columns)
	local cursor_col = vim.fn.virtcol(".")

	-- Calculate the leftmost column to display
	-- We add 10 to shift the cursor slightly to the right of center
	local left_col = math.max(cursor_col - math.floor(win_width / 2), 0) + 10

	-- Disable line wrapping
	vim.api.nvim_win_set_option(0, "wrap", false)

	-- Adjust the view
	vim.fn.winrestview({ leftcol = left_col })
end

return M
