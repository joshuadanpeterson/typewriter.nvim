--- Autocommands setup for Typewriter.nvim
---
--- This module defines and sets up autocommands and user commands related to Typewriter.nvim.
--- It handles the creation of user commands for controlling Typewriter mode and
--- integrates with Zen Mode and True Zen plugins.
---
--- @module typewriter.autocommands
--- @file lua/typewriter/autocommands.lua
--- @tag typewriter-autocommands

local config = require("typewriter.config")
local commands = require("typewriter.commands")

local M = {}

--- Setup autocommands and user commands
---
--- This function creates user commands for controlling Typewriter mode and sets up
--- autocommands for integration with Zen Mode and True Zen plugins.
---
--- User commands created:
--- - TWEnable: Enable typewriter mode
--- - TWDisable: Disable typewriter mode
--- - TWToggle: Toggle typewriter mode
--- - TWCenter: Center the current code block and cursor
--- - TWTop: Move the top of the current code block to the top of the screen
--- - TWBottom: Move the bottom of the current code block to the bottom of the screen
---
--- @usage require("typewriter.autocommands").autocmd_setup()
function M.autocmd_setup()
	-- User commands
	vim.api.nvim_create_user_command("TWEnable", function()
		commands.enable_typewriter_mode()
	end, { desc = "Enable Typewriter mode" })

	vim.api.nvim_create_user_command("TWDisable", function()
		commands.disable_typewriter_mode()
	end, { desc = "Disable Typewriter mode" })

	vim.api.nvim_create_user_command("TWToggle", function()
		commands.toggle_typewriter_mode()
	end, { desc = "Toggle Typewriter mode" })

	vim.api.nvim_create_user_command("TWCenter", function()
		commands.center_block_and_cursor()
	end, { desc = "Center the current code block and cursor" })

	vim.api.nvim_create_user_command("TWTop", function()
		commands.move_to_top_of_block()
	end, { desc = "Move the top of the current code block to the top of the screen" })

	vim.api.nvim_create_user_command("TWBottom", function()
		commands.move_to_bottom_of_block()
	end, { desc = "Move the bottom of the current code block to the bottom of the screen" })

	-- Preserve column position when moving between lines of different lengths
	local target_col = nil
	local last_line = nil

	vim.api.nvim_create_autocmd("CursorMoved", {
		pattern = "*",
		callback = function()
			local current_line, current_col = unpack(vim.api.nvim_win_get_cursor(0))
			local line_length = vim.fn.col('$') - 1 -- Get the actual length of the current line

			-- If we've moved to a new line
			if last_line ~= current_line then
				-- If target_col is not set, use the current column
				if target_col == nil then
					target_col = current_col
				end

				-- If the current line is shorter than target_col, move to the end of the line
				if line_length < target_col then
					vim.api.nvim_win_set_cursor(0, { current_line, line_length })
					-- If the current line is long enough, move to the target column
				elseif current_col ~= target_col then
					vim.api.nvim_win_set_cursor(0, { current_line, target_col })
				end
			else
				-- If we're on the same line, update the target column
				target_col = current_col
			end

			last_line = current_line

			-- Center the cursor
			commands.center_cursor()
		end
	})

	-- Autocommands for ZenMode integration
	if config.config.enable_with_zen_mode then
		vim.api.nvim_create_autocmd("User", {
			pattern = "ZenModePre",
			callback = function()
				commands.enable_typewriter_mode()
			end,
			desc = "Enable Typewriter mode when entering Zen Mode",
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "ZenModeLeave",
			callback = function()
				commands.disable_typewriter_mode()
			end,
			desc = "Disable Typewriter mode when leaving Zen Mode",
		})
	end

	-- Autocommands for True Zen integration
	if config.config.enable_with_true_zen then
		vim.api.nvim_create_autocmd("User", {
			pattern = "TZWoon",
			callback = function()
				commands.enable_typewriter_mode()
			end,
			desc = "Enable Typewriter mode when entering True Zen",
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "TZOff",
			callback = function()
				commands.disable_typewriter_mode()
			end,
			desc = "Disable Typewriter mode when leaving True Zen",
		})
	end
end

return M
