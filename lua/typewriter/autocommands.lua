--- Autocommands setup for Typewriter.nvim
---
--- @module typewriter.autocommands
--- @file lua/typewriter/autocommands.lua
--- @tag typewriter-autocommands

local config = require("typewriter.config")
local commands = require("typewriter.commands")
local ts_utils = require('nvim-treesitter.ts_utils')
local ts_parsers = require('nvim-treesitter.parsers')
local utils = require('typewriter.utils')
local logger = require('typewriter.logger')

local M = {}

-- State management
local State = {
	NORMAL = 1,
	SEARCH = 2,
	PRESERVE_COLUMN = 3
}

local current_state = State.NORMAL
local target_col = nil
local last_line = nil
-- Forward declare local helpers to avoid polluting the global namespace
local move_cursor_to_combined_match
local get_treesitter_match
local validate_position_with_lsp
local move_cursor_to_regex_match

-- Helper function to set state
local function set_state(new_state)
	current_state = new_state
end

-- Function to handle column preservation
local function handle_column_preservation()
	if current_state ~= State.PRESERVE_COLUMN then return end

	local current_line, current_col = unpack(vim.api.nvim_win_get_cursor(0))
	local line_length = vim.fn.col('$') - 1

	if last_line ~= current_line then
		if target_col == nil then
			target_col = current_col
		end

		if line_length < target_col then
			vim.api.nvim_win_set_cursor(0, { current_line, line_length })
		elseif current_col ~= target_col then
			vim.api.nvim_win_set_cursor(0, { current_line, target_col })
		end
	else
		target_col = current_col
	end

	last_line = current_line
	commands.center_cursor()
end

-- Function to handle search activation
local function handle_search_activation()
	set_state(State.SEARCH)
end

-- Function to handle search completion
local function handle_search_completion()
        if vim.fn.mode() == "n" then
                if utils.is_typewriter_active() then
                        set_state(State.PRESERVE_COLUMN)
                else
                        set_state(State.NORMAL)
                end
                if vim.v.hlsearch == 1 then
                        local search_pattern = vim.fn.getreg("/")
                        move_cursor_to_combined_match(search_pattern)
                end
        end
end

--- Move cursor to the best match found using Treesitter and LSP
---
--- @param search_pattern string The search pattern to match against symbols and nodes
move_cursor_to_combined_match = function(search_pattern)
	local bufnr = vim.api.nvim_get_current_buf()

	-- Treesitter Phase
	local ts_position = get_treesitter_match(bufnr, search_pattern)
	if ts_position then
		-- Validate Treesitter position with LSP
		local validated_position = validate_position_with_lsp(ts_position, search_pattern)
		if validated_position then
			vim.api.nvim_win_set_cursor(0, validated_position)
			return
		else
			vim.api.nvim_win_set_cursor(0, ts_position)
			return
		end
	end

        -- Fallback to regex if both Treesitter and LSP fail. This is not a
        -- critical error, just an alternative search path.
        logger.warning("Falling back to regex search for pattern: " .. search_pattern)
        move_cursor_to_regex_match(bufnr, search_pattern)
end

--- Get match position using Treesitter
---
--- @param bufnr number Buffer number
--- @param search_pattern string Search pattern
--- @return table|nil Cursor position
get_treesitter_match = function(bufnr, search_pattern)
	local lang = ts_parsers.get_buf_lang(bufnr)
	if not lang then
		return nil
	end

	local root = ts_utils.get_root_for_position(0, 0, bufnr)
	if not root then
		return nil
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
		return nil
	end

        -- Preprocess the search pattern to handle special characters and word boundaries
        local regex_pattern = utils.create_escaped_regex_pattern(search_pattern)

	-- Iterate over captures and match against the search pattern
	local cursor_position
	query:for_each_match(root, bufnr, 0, function(_, match, _)
		for _, node in ipairs(match) do
			local node_text = ts_utils.get_node_text(node, bufnr)[1]
			if node_text then
				-- Find the exact position of the match within the node
				local start_pos = node_text:find(regex_pattern)
				if start_pos then
					local start_row, start_col = node:start()
					cursor_position = { start_row + 1, start_col + start_pos - 1 } -- Adjust for zero-based index
					return true                 -- Stop iteration after finding the first match
				end
			end
		end
	end)

	return cursor_position
end

--- Validate position with LSP
---
--- @param position table Initial position from Treesitter
--- @param search_pattern string Search pattern
--- @return table|nil Validated cursor position
local function validate_lsp_symbols(position, search_pattern, symbols)
        for _, symbol in ipairs(symbols) do
                if symbol.name:find(search_pattern) then
                        local range = symbol.location.range
                        local lsp_position = { range.start.line + 1, range.start.character }

                        if lsp_position[1] == position[1] and lsp_position[2] == position[2] then
                                return lsp_position
                        end
                end

                if symbol.children then
                        local child_position = validate_lsp_symbols(position, search_pattern, symbol.children)
                        if child_position then
                                return child_position
                        end
                end
        end

        return nil
end

validate_position_with_lsp = function(position, search_pattern)
        local bufnr = vim.api.nvim_get_current_buf()
        local params = { textDocument = vim.lsp.util.make_text_document_params() }

        -- Use LSP to get document symbols
        local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/documentSymbol', params, 1000)

        if not result or vim.tbl_isempty(result) then
                return nil
        end

        for _, res in pairs(result) do
                local validated = validate_lsp_symbols(position, search_pattern, res.result or {})
                if validated then
                        return validated
                end
        end

        return nil
end

--- Fallback to regex match
---
--- @param bufnr number Buffer number
--- @param search_pattern string Search pattern
move_cursor_to_regex_match = function(bufnr, search_pattern)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local regex_pattern = utils.create_escaped_regex_pattern(search_pattern)

	for line_num, line in ipairs(lines) do
		local start_pos = line:find(regex_pattern)
		if start_pos then
			local cursor_position = { line_num, start_pos - 1 }
			vim.api.nvim_win_set_cursor(0, cursor_position)
			return
		end
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
--- - TWPreserveColumn: Toggle column preservation on or off
---
--- @usage require("typewriter.autocommands").autocmd_setup()
function M.autocmd_setup()
	-- User commands
	vim.api.nvim_create_user_command("TWEnable", function()
		commands.enable_typewriter_mode()
		set_state(State.PRESERVE_COLUMN) -- Enable column preservation when typewriter mode is active
	end, { desc = "Enable Typewriter mode" })

	vim.api.nvim_create_user_command("TWDisable", function()
		-- Disable typewriter mode
		commands.disable_typewriter_mode()

		-- Check if column preservation is active, and reset state to NORMAL
		if current_state == State.PRESERVE_COLUMN then
			set_state(State.NORMAL)
			print("Column preservation disabled")
		end

		-- Clear any autocmds related to column preservation or cursor movement
		vim.api.nvim_clear_autocmds({
			event = "CursorMoved",
			buffer = 0, -- for the current buffer
		})
	end, { desc = "Disable Typewriter mode and column preservation" })

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

	-- Toggle column preservation mode
	vim.api.nvim_create_user_command("TWPreserveColumn", function()
		if current_state == State.PRESERVE_COLUMN then
			set_state(State.NORMAL)
			print("Column preservation disabled")
		else
			set_state(State.PRESERVE_COLUMN)
			target_col = nil
			last_line = nil
			print("Column preservation enabled")
		end
	end, { desc = "Toggle column preservation mode" })

	-- Autocommand for cursor movement
	vim.api.nvim_create_autocmd("CursorMoved", {
		pattern = "*",
		callback = function()
			-- Only preserve column if typewriter mode is active
			if current_state == State.PRESERVE_COLUMN and utils.is_typewriter_active() then
				handle_column_preservation()
			elseif current_state == State.NORMAL then
				commands.center_cursor()
				-- Default Neovim behavior (no column preservation)
				-- We don't interfere with the default behavior when not in typewriter mode
				return
			end
		end,
	})

	-- Autocommand for search activation
	vim.api.nvim_create_autocmd("CmdlineEnter", {
		pattern = "/,?",
		callback = handle_search_activation,
	})

	-- Autocommand for search completion
	vim.api.nvim_create_autocmd("CmdlineLeave", {
		pattern = "/,?",
		callback = handle_search_completion,
	})

	-- ZenMode and True Zen integration (same as before)
	-- Autocommands for ZenMode integration
	if config.config.enable_with_zen_mode then
                vim.api.nvim_create_autocmd("User", {
                        pattern = "ZenModePre",
                        callback = function()
                                commands.enable_typewriter_mode()
                                set_state(State.PRESERVE_COLUMN)
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
                                set_state(State.PRESERVE_COLUMN)
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

        -- Log plugin shutdown
        vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                        logger.info("Typewriter.nvim shutdown")
                end,
        })
end

--- Enable column preservation state
function M.enable_column_preservation()
        set_state(State.PRESERVE_COLUMN)
end

--- Disable column preservation state
function M.disable_column_preservation()
        set_state(State.NORMAL)
end

--- Get the current internal state (for testing)
-- @return number current state
function M.get_state()
        return current_state
end

return M
