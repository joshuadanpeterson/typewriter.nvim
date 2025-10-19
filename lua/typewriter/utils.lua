--- Utility functions for Typewriter.nvim
---
--- This module contains utility functions used throughout Typewriter.nvim.
--- It provides functionality for user notifications, horizontal cursor centering,
--- and Typewriter mode state management.
---
--- @module typewriter.utils
--- @file lua/typewriter/utils.lua
--- @tag typewriter-utils

local config = require("typewriter.config")

-- Private variable to store the active state
local typewriter_active = false

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
	local win_width = vim.api.nvim_win_get_width(0)
	local cursor_col = vim.fn.virtcol(".")
	local base_left = math.max(cursor_col - math.floor(win_width / 2), 0)
	local offset = tonumber(config.config.horizontal_left_offset) or 0
	local left_col = math.max(base_left + offset, 0)
	vim.api.nvim_win_set_option(0, "wrap", false)
	vim.fn.winrestview({ leftcol = left_col })
end

--- Check if Typewriter mode is currently active
---
--- @return boolean True if Typewriter mode is active, false otherwise
--- @usage
--- local utils = require("typewriter.utils")
--- if utils.is_typewriter_active() then
---     print("Typewriter mode is active")
--- end
function M.is_typewriter_active()
	return typewriter_active
end

--- Set the active state of Typewriter mode
---
--- @param active boolean The new active state
--- @usage
--- local utils = require("typewriter.utils")
--- utils.set_typewriter_active(true)
function M.set_typewriter_active(active)
	typewriter_active = active
	vim.api.nvim_exec_autocmds("User", { pattern = "TypewriterStateChanged" })
end

--- Toggle the active state of Typewriter mode
---
--- @return boolean The new active state
--- @usage
--- local utils = require("typewriter.utils")
--- local new_state = utils.toggle_typewriter_active()
--- print("Typewriter mode is now: " .. (new_state and "active" or "inactive"))
function M.toggle_typewriter_active()
	typewriter_active = not typewriter_active
	M.set_typewriter_active(typewriter_active)
	return typewriter_active
end

return M
