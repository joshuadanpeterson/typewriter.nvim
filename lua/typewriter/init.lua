--- Typewriter.nvim
---
--- This plugin provides typewriter scrolling for neovim.
--- It keeps the cursor centered on the screen and provides advanced code block navigation.
---
--- @module typewriter
--- @file lua/typewriter/init.lua
--- @tag typewriter.nvim

local config = require("typewriter.config")
local autocommands = require("typewriter.autocommands")

local M = {}

--- Setup the plugin
--- @param user_config table: User configuration
function M.init_setup(user_config)
	config.setup(user_config)
	autocommands.setup()
end

return M
