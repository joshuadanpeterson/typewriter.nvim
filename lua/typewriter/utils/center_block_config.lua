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
	["function"] = true,
	["body"] = true,
	["method"] = true,
	["table"] = true,
	["if_statement"] = true,
	["class"] = true,
	["block"] = true,
	["module"] = true,
	["namespace"] = true,
	["program"] = true,
	["source"] = true,
	["for_loop"] = true,
	["while_loop"] = true,
	["conditional"] = true,
	["try_statement"] = true,
	["catch_clause"] = true,
	["finally_clause"] = true,
	["switch_statement"] = true,
	["case_statement"] = true,
	["else_clause"] = true,
	["do_statement"] = true,
	["repeat_statement"] = true,
	["function_call"] = true,
	["function_definition"] = true,
	["arrow_function"] = true,
	["function_expression"] = true,
	["generator_function"] = true,
	["async_function"] = true,
	["object"] = true,
	["array"] = true,
	["property"] = true,
	["field"] = true,
	["parameter"] = true,
	["constructor"] = true,
	["decorator"] = true,
	["import_statement"] = true,
	["export_statement"] = true,
	["try_expression"] = true,
	["match_statement"] = true,
	["enum_declaration"] = true,
	["interface_declaration"] = true,
	["type_alias"] = true,
	["variable_declaration"] = true,
	["lexical_declaration"] = true,
	["assignment"] = true,
	["expression_statement"] = true,
	["return_statement"] = true,
	["throw_statement"] = true,
	["await_expression"] = true,
	["declaration_list"] = true,
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
