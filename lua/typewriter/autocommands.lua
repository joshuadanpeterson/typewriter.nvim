--- Autocommands setup for Typewriter.nvim
---
--- This module defines and sets up autocommands related to Typewriter.nvim.
---
--- @module typewriter.autocommands
--- @file lua/typewriter/autocommands.lua
--- @tag typewriter-autocommands

local config = require("typewriter.config")
local commands = require("typewriter.commands")

local M = {}

--- Setup autocommands and user commands
function M.autocmd_setup()
	-- User commands
	--- Enable typewriter mode
	vim.api.nvim_create_user_command("TWEnable", function()
		commands.enable_typewriter_mode()
	end, {})
	--- Disable typewriter mode
	vim.api.nvim_create_user_command("TWDisable", function()
		commands.disable_typewriter_mode()
	end, {})
	--- Toggle typewriter mode
	vim.api.nvim_create_user_command("TWToggle", function()
		commands.toggle_typewriter_mode()
	end, {})
	--- Center the current code block and cursor
	vim.api.nvim_create_user_command("TWCenter", function()
		commands.center_block_and_cursor()
	end, {})
	--- Move the top of the current code block to the top of the screen
	vim.api.nvim_create_user_command("TWTop", function()
		commands.move_to_top_of_block()
	end, {})
	--- Move the bottom of the current code block to the bottom of the screen
	vim.api.nvim_create_user_command("TWBottom", function()
		commands.move_to_bottom_of_block()
	end, {})

	-- Autocommands for ZenMode integration
	if config.config.enable_with_zen_mode then
		vim.api.nvim_command('autocmd User ZenModePre lua require("typewriter.commands").enable_typewriter_mode()')
		vim.api.nvim_command('autocmd User ZenModeLeave lua require("typewriter.commands").disable_typewriter_mode()')
	end

	-- Autocommands for True Zen integration
	if config.config.enable_with_true_zen then
		vim.api.nvim_command('autocmd User TZWoon lua require("typewriter.commands").enable_typewriter_mode()')
		vim.api.nvim_command('autocmd User TZOff lua require("typewriter.commands").disable_typewriter_mode()')
	end
end

return M
