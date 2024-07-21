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
	["function_definition"] = true,
	["class"] = true,
	["class_declaration"] = true,
	["method_declaration"] = true,
	["arrow_function"] = true,
	["generator_function"] = true,
	["async_function"] = true,
	["local_declaration"] = true,
	["declaration_list"] = true,
	["function_call"] = true,
	["assignment_statement"] = true,
	["return_statement"] = true,

	-- Language-specific significant blocks
	-- PHP
	["namespace"] = true,
	["php_tag"] = true,
	["property_declaration"] = true,
	["foreach_statement"] = true,

	-- Lua
	["block"] = true,
	["parameters"] = true,
	["body"] = true,
	["condition"] = true,

	-- Go
	["package_clause"] = true,
	["import_declaration"] = true,
	["type_declaration"] = true,
	["type_spec"] = true,
	["struct_type"] = true,
	["parameter_list"] = true,
	["parameter_declaration"] = true,
	["selector_expression"] = true,
	["argument_list"] = true,
	["short_var_declaration"] = true,
	["expression_list"] = true,
	["for_clause"] = true,
	["initializer"] = true,
	["update"] = true,
	["inc_statement"] = true,
	["expression_switch_statement"] = true,
	["expression_case"] = true,
	["default_case"] = true,
	["defer_statement"] = true,
	["go_statement"] = true,

	-- Rust
	["impl_block"] = true,
	["trait"] = true,
	["mod"] = true,
	["scoped_identifier"] = true,
	["use_wildcard"] = true,
	["primitive_type"] = true,
	["parameter"] = true,
	["pattern"] = true,
	["struct_expression"] = true,
	["field_initializer_list"] = true,
	["shorthand_field_initializer"] = true,
	["macro_invocation"] = true,
	["token_tree"] = true,
	["tuple_expression"] = true,
	["string_content"] = true,
	["field_expression"] = true,
	["enum_variant_list"] = true,
	["enum_variant"] = true,
	["reference_type"] = true,
	["lifetime"] = true,
	["match_block"] = true,
	["match_arm"] = true,
	["match_pattern"] = true,
	["integer_literal"] = true,
	["boolean_literal"] = true,
	["let_declaration"] = true,
	["mutable_specifier"] = true,
	["reference_expression"] = true,
	["range_expression"] = true,
	["compound_assignment_expr"] = true,

	-- JavaScript
	["lexical_declaration"] = true,
	["for_in_statement"] = true,
	["expression_statement"] = true,
	["function_expression"] = true,

	-- Python
	["except_clause"] = true,
	["def"] = true,
	["import_statement"] = true,
	["import_from_statement"] = true,
	["decorated_definition"] = true,

	-- HTML
	["tag"] = true,
	["script"] = true,
	["style"] = true,

	-- CSS
	["rule"] = true,
	["media"] = true,
	["keyframes"] = true,

	-- Bash
	["for_statement"] = true,
	["while_statement"] = true,
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
