-- lua/typewriter/autocommands.lua
-- Setup for autocommands related to Typewriter.nvim

local config = require("typewriter.config")
local commands = require("typewriter.commands")

local M = {}

function M.setup()
	vim.api.nvim_create_user_command("TWEnable", commands.enable_typewriter_mode, {})
	vim.api.nvim_create_user_command("TWDisable", commands.disable_typewriter_mode, {})
	vim.api.nvim_create_user_command("TWToggle", commands.toggle_typewriter_mode, {})
	vim.api.nvim_create_user_command("TWCenter", commands.center_block_and_cursor, {})
	vim.api.nvim_create_user_command("TWTop", commands.move_to_top_of_block, {})
	vim.api.nvim_create_user_command("TWBottom", commands.move_to_bottom_of_block, {})

	if config.config.enable_with_zen_mode then
		vim.api.nvim_command('autocmd User ZenModePre lua require("typewriter.commands").enable_typewriter_mode()')
		vim.api.nvim_command('autocmd User ZenModeLeave lua require("typewriter.commands").disable_typewriter_mode()')
	end
	if config.config.enable_with_true_zen then
		vim.api.nvim_command('autocmd User TZWoon lua require("typewriter.commands").enable_typewriter_mode()')
		vim.api.nvim_command('autocmd User TZOff lua require("typewriter.commands").disable_typewriter_mode()')
	end
end

return M
