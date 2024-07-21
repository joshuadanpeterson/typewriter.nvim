--- Configuration for significant code blocks to center in Typewriter.nvim
---
--- This module defines the types of code blocks that should be centered when using
--- Typewriter.nvim's block centering features. It provides a configuration table
--- that determines which syntax tree nodes are considered "significant" and should
--- trigger centering behavior.
---
--- @module typewriter.utils.center_block_config
--- @file lua/typewriter/utils/center_block_config.lua
--- @tag typewriter-center-block-config

local M = {}

--- Table indicating which code blocks should be expanded and centered
---
--- This table maps syntax tree node types to boolean values. When a node type
--- is set to `true`, it will be considered a significant block and will trigger
--- centering behavior in Typewriter.nvim's block navigation functions.
---
--- Users can modify this table to customize which types of code blocks are
--- considered significant in their workflow.
---
--- @type table<string, boolean>
--- @usage
--- -- To add a new node type or modify an existing one:
--- local center_block_config = require("typewriter.utils.center_block_config")
--- center_block_config.expand["my_custom_node"] = true
---
--- -- To disable centering for a specific node type:
--- center_block_config.expand["function"] = false
M.expand = {
	-- Common significant blocks across many languages
	["function"] = true,
	["method"] = true,
	["if_statement"] = true,
	["for_loop"] = true,
	["while_loop"] = true,
	["switch_statement"] = true,
	["case_statement"] = true,
	["try_statement"] = true,
	["catch_clause"] = true,
	["finally_clause"] = true,
	["do_statement"] = true,
	["repeat_statement"] = true,
	["function_declaration"] = true,
	["class"] = true,
	["class_declaration"] = true,
	["method_declaration"] = true,
	["arrow_function"] = true,
	["generator_function"] = true,
	["async_function"] = true,
	["local_declaration"] = true,
	["declaration_list"] = true,
	["function_call"] = true,

	-- Language-specific significant blocks
	-- PHP
	["namespace"] = true,

	-- Lua
	-- (covered by common significant blocks)

	-- Go
	["package"] = true,

	-- Rust
	["match_statement"] = true,
	["impl_block"] = true,
	["struct"] = true,
	["enum"] = true,
	["trait"] = true,
	["mod"] = true,

	-- JavaScript
	["function_expression"] = true,

	-- Python
	["except_clause"] = true,
	["def"] = true,

	-- HTML
	["tag"] = true,
	["script"] = true,
	["style"] = true,

	-- CSS
	["rule"] = true,
	["media"] = true,
	["keyframes"] = true,

	-- Bash
	["function_definition"] = true,
	["for_statement"] = true,
	["while_statement"] = true,
	["if_statement"] = true,
	["declaration_command"] = true,

	-- SQL
	["select_statement"] = true,
	["insert_statement"] = true,
	["update_statement"] = true,
	["delete_statement"] = true,
	["create_statement"] = true,
	["alter_statement"] = true,
	["drop_statement"] = true,
	["begin_statement"] = true,
	["commit_statement"] = true,
	["rollback_statement"] = true,
}

--- Get the expansion status for a given node type
---
--- @param node_type string The type of the syntax tree node
--- @return boolean Whether the node type should be expanded and centered
--- @usage
--- local center_block_config = require("typewriter.utils.center_block_config")
--- local should_expand = center_block_config.should_expand("function")
function M.should_expand(node_type)
	return M.expand[node_type] == true
end

return M
