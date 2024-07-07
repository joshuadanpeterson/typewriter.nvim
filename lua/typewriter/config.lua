--- Configuration management for Typewriter.nvim
---
--- @module typewriter.config
--- @file lua/typewriter/config.lua
--- @tag typewriter-config

local M = {}

--- Default configuration
---
--- @type table
M.default_config = {
	enable_with_zen_mode = true,
	enable_with_true_zen = true,
	keep_cursor_position = true,
	enable_notifications = true,
	enable_horizontal_scroll = true,
}

--- Current configuration
---
--- @type table
M.config = M.default_config

--- Setup the configuration
--- @param user_config table: User configuration
function M.config_setup(user_config)
	if type(user_config) == "table" then
		M.config = vim.tbl_extend("force", M.config, user_config)
	end
end

return M
