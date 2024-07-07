--- Typewriter.nvim
---
--- This plugin provides typewriter-style scrolling for Neovim.
--- It keeps the cursor centered on the screen and provides advanced code block navigation.
---
--- Features:
--- * Centered cursor while typing and scrolling
--- * Integration with Zen Mode and True Zen
--- * Advanced code block navigation
--- * Customizable behavior through configuration options
---
--- @module typewriter
--- @file lua/typewriter/init.lua
--- @tag typewriter.nvim
--- @author Your Name
--- @license MIT

-- Import required modules
local config = require("typewriter.config")
local autocommands = require("typewriter.autocommands")

local M = {}

--- Setup the Typewriter.nvim plugin
---
--- This function initializes the plugin with the provided user configuration
--- and sets up the necessary autocommands.
---
--- @param user_config table User configuration options (optional)
--- @usage
--- require('typewriter').setup({
---     enable_with_zen_mode = false,
---     keep_cursor_position = true
--- })
function M.setup(user_config)
	print("Typewriter setup function called")
	print("User config:", vim.inspect(user_config))

	-- Configure the plugin
	local status, err = pcall(function()
		config.config_setup(user_config or {})
	end)
	if not status then
		print("Error in config setup:", err)
		return
	end

	-- Set up autocommands
	status, err = pcall(function()
		autocommands.autocmd_setup()
	end)
	if not status then
		print("Error in autocommand setup:", err)
		return
	end

	print("Typewriter setup completed successfully")
end
