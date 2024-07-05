-- lua/typewriter/init.lua
-- This plugin provides typewriter scrolling for neovim.
-- Entry point to set up Typewriter.nvim

local config = require("typewriter.config")
local autocommands = require("typewriter.autocommands")

local M = {}

function M.setup(user_config)
	config.setup(user_config)
	autocommands.setup()
end

return M
