--- Configuration management for Typewriter.nvim
---
--- This module handles the configuration options for Typewriter.nvim,
--- allowing users to customize the plugin's behavior.
---
--- @module typewriter.config
--- @file lua/typewriter/config.lua
--- @tag typewriter-config

local M = {}

--- Default configuration options for Typewriter.nvim
---
--- These values will be used if the user doesn't override them.
---
--- @type table
M.default_config = {
	--- Enable typewriter mode with Zen Mode
	--- When true, typewriter mode will activate automatically with Zen Mode.
	--- @type boolean
	enable_with_zen_mode = true,

	--- Enable typewriter mode with True Zen
	--- When true, typewriter mode will activate automatically with True Zen.
	--- @type boolean
	enable_with_true_zen = true,

	--- Keep cursor position when centering blocks
	--- When true, the cursor position within a block is maintained when centering.
	--- @type boolean
	keep_cursor_position = true,

	--- Enable notifications
	--- When true, the plugin will display notifications for certain actions.
	--- @type boolean
	enable_notifications = true,

	--- Enable horizontal scrolling
	--- When true, the plugin will center text horizontally as well as vertically.
	--- @type boolean
	enable_horizontal_scroll = true,
}

--- Current configuration
---
--- This table holds the active configuration, which is a combination of
--- default values and user-provided overrides.
---
--- @type table
M.config = M.default_config

--- Setup the configuration
---
--- This function merges the user-provided configuration with the default configuration.
--- It allows users to override only the options they want to change.
---
--- @param user_config table User configuration options
--- @usage
--- require('typewriter.config').config_setup({
---     enable_with_zen_mode = false,
---     enable_notifications = false
--- })
function M.config_setup(user_config)
	if type(user_config) == "table" then
		M.config = vim.tbl_extend("force", M.config, user_config)
	end
end

--- Get the current configuration
---
--- This function returns the current active configuration.
---
--- @return table Current configuration
--- @usage
--- local current_config = require('typewriter.config').get_config()
function M.get_config()
	return M.config
end

return M
