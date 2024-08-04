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
local ts_utils = require('nvim-treesitter.ts_utils')
local ts_parsers = require('nvim-treesitter.parsers')

local M = {}

--- Move cursor to the first match found by Treesitter
---
--- @param search_pattern string The search pattern to match against nodes
local function move_cursor_to_treesitter_match(search_pattern)
	local bufnr = vim.api.nvim_get_current_buf()
	local lang = ts_parsers.get_buf_lang(bufnr)
	if not lang then
		print("Treesitter parser not available for this buffer.")
		return
	end

	local root = ts_utils.get_root_for_position(0, 0, bufnr)
	if not root then
		return
	end

	-- Define a query to capture specific node types
	local query = vim.treesitter.query.parse(lang, [[
        (identifier) @match
        (string) @match
        (comment) @match
        (function_declaration name: (identifier) @match)
        (variable_declaration name: (identifier) @match)
        (property_identifier) @match
        (function_name) @match
        (type_identifier) @match
    ]])

	if not query then
		print("No Treesitter query available for this language.")
		return
	end

	-- Preprocess the search pattern to handle special characters and word boundaries
	local regex_pattern = string.format("\\b%s\\b", search_pattern:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0"))

	-- Iterate over captures and match against the search pattern
	local cursor_position
	query:for_each_match(root, bufnr, 0, function(_, match, _)
		for _, node in ipairs(match) do
			local node_text = ts_utils.get_node_text(node, bufnr)[1]
			if node_text then
				-- Find the exact position of the match within the node
				local start_pos, end_pos = node_text:find(regex_pattern)
				if start_pos then
					local start_row, start_col = node:start()
					cursor_position = { start_row + 1, start_col + start_pos - 1 } -- Adjust for zero-based index
					return true                 -- Stop iteration after finding the first match
				end
			end
		end
	end)

	if cursor_position then
		vim.api.nvim_win_set_cursor(0, cursor_position)
	else
		print("No match found with Treesitter.")
	end
end

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

	-- Autocommand to handle cursor positioning during search navigation
	vim.api.nvim_create_autocmd({ "CursorMoved", "CmdlineLeave" }, {
		pattern = "*",
		callback = function()
			if vim.v.hlsearch == 1 and vim.fn.mode() == "n" then
				local search_pattern = vim.fn.getreg("/")
				move_cursor_to_treesitter_match(search_pattern)
			end

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
