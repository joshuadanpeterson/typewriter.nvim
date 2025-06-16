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

--- Import required modules
--- local config = require("typewriter.config")
--- local autocommands = require("typewriter.autocommands")
local logger = require("typewriter.logger")
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

M.setup = function(user_config)
        config = require("typewriter.config")

        autocommands = require("typewriter.autocommands")
        local commands = require("typewriter.commands")

        config.config_setup(user_config or {})
        autocommands.autocmd_setup()
        if config.config.start_enabled then
                commands.enable_typewriter_mode()
        end
        require("typewriter.utils").notify("Typewriter.nvim started")
        logger.info("Typewriter.nvim started")
end

return M
