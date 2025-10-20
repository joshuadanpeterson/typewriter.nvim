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
	["block"] = true,
	["parameters"] = true,
	["body"] = true,
	["condition"] = true,
	["property_name"] = true,
	["integer_value"] = true,
	["unit"] = true,
	["plain_value"] = true,
	["color_value"] = true,
	["tag_name"] = true,
	["string_content"] = true,
	["import_declaration"] = true,
	["property_declaration"] = true,
	["type_identifier"] = true,
	["call_expression"] = true,
	["function_body"] = true,
	["parameter"] = true,
	["return_statement"] = true,
	["identifier"] = true,
	["expression_statement"] = true,
	["declaration"] = true,
	["argument_list"] = true,
	["binary_expression"] = true,
	["foreach_statement"] = true,
	["init_declarator"] = true,
	["preproc_include"] = true,
	["constructor_declaration"] = true,
	["field_declaration"] = true,

	-- Language-specific significant blocks
	-- PHP
	["namespace"] = true,
	["php_tag"] = true,

	-- Go
	["package_clause"] = true,
	["type_declaration"] = true,
	["type_spec"] = true,
	["struct_type"] = true,
	["selector_expression"] = true,
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
	["pattern"] = true,
	["struct_expression"] = true,
	["field_initializer_list"] = true,
	["shorthand_field_initializer"] = true,
	["macro_invocation"] = true,
	["token_tree"] = true,
	["tuple_expression"] = true,
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
	["function_expression"] = true,

	-- Python
	["except_clause"] = true,
	["def"] = true,
	["import_statement"] = true,
	["import_from_statement"] = true,
	["decorated_definition"] = true,

	-- HTML
	["doctype"] = true,
	["element"] = true,
	["start_tag"] = true,
	["attribute"] = true,
	["text"] = true,
	["end_tag"] = true,
	["style_element"] = true,
	["script_element"] = true,

	-- CSS
	["rule_set"] = true,
	["selectors"] = true,
	["class_selector"] = true,
	["pseudo_class_selector"] = true,
	["attribute_selector"] = true,
	["media_statement"] = true,
	["feature_query"] = true,

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

	-- YAML
	["document"] = true,
	["block_node"] = true,
	["block_mapping"] = true,
	["block_mapping_pair"] = true,
	["key: flow_node"] = true,
	["value: flow_node"] = true,
	["plain_scalar"] = true,
	["string_scalar"] = true,
	["block_sequence"] = true,
	["block_sequence_item"] = true,
	["block_scalar"] = true,
	["integer_scalar"] = true,
	["boolean_scalar"] = true,

	-- JSON
	["object"] = true,
	["pair"] = true,
	["key: string"] = true,
	["value: string"] = true,
	["value: object"] = true,
	["value: array"] = true,
	["escape_sequence"] = true,
	["value: number"] = true,

	-- Dart
	["class_definition"] = true,
	["function_signature"] = true,
	["method_signature"] = true,
	["import_or_export"] = true,
	["constructor_signature"] = true,
	["argument_part"] = true,
	["local_variable_declaration"] = true,
	["initialized_variable_definition"] = true,

	-- Swift
	["inheritance_specifier"] = true,
	["class_body"] = true,

	-- C++
	["class_specifier"] = true,
	["for_range_loop"] = true,
	["string_literal"] = true,

	-- C#
	["using_directive"] = true,
	["namespace_declaration"] = true,
	["modifier"] = true,
	["variable_declaration"] = true,

	-- C
	["parameter_list"] = true,
	["parameter_declaration"] = true,
	["compound_statement"] = true,
	["struct_specifier"] = true,

	-- Zig
	["line_comment"] = true,
	["Decl"] = true,
	["VarDecl"] = true,
	["FnProto"] = true,
	["AssignExpr"] = true,
	["BinaryExpr"] = true,
	["Block"] = true,
	["Statement"] = true,
	["IfStatement"] = true,
	["ForStatement"] = true,
	["WhileStatement"] = true,
	["SwitchExpr"] = true,
	["SwitchProng"] = true,

	-- OCaml
	["comment"] = true,
	["type_definition"] = true,
	["type_binding"] = true,
	["type_constructor"] = true,
	["record_declaration"] = true,
	["field_name"] = true,
	["type_constructor_path"] = true,
	["value_definition"] = true,
	["let_binding"] = true,
	["value_name"] = true,
	["record_expression"] = true,
	["application_expression"] = true,
	["if_expression"] = true,
	["match_expression"] = true,
	["variant_declaration"] = true,
	["constructor_name"] = true,
	["let_expression"] = true,

	-- Java-specific significant blocks
	["throw_statement"] = true,

	-- LaTeX
	["document"] = true,
	["preamble"] = true,
	["package_include"] = true,
	["title_declaration"] = true,
	["author_declaration"] = true,
	["generic_environment"] = true,
	["math_environment"] = true,
	["environment"] = true,
	["begin"] = true,
	["end"] = true,
	["section"] = true,
	["subsection"] = true,
	["subsubsection"] = true,
	["chapter"] = true,
	["part"] = true,
	["paragraph"] = true,
	["subparagraph"] = true,
	["enum_item"] = true,
	["unordered_list"] = true,
	["ordered_list"] = true,
	["item"] = true,
	["figure"] = true,
	["table"] = true,
	["tabular"] = true,
	["array"] = true,
	["matrix"] = true,
	["cases"] = true,
	["align"] = true,
	["equation"] = true,
	["displaymath"] = true,
	["inline_math"] = true,
	["text"] = true,
	["curly_group"] = true,
	["curly_group_text"] = true,
	["generic_command"] = true,
	["text_mode"] = true,
	["cite"] = true,
	["ref"] = true,
	["label"] = true,
	["new_command_definition"] = true,
	["theorem"] = true,
	["proof"] = true,
	["definition"] = true,
	["lemma"] = true,
	["proposition"] = true,
	["corollary"] = true,
	["remark"] = true,
	["example"] = true,
	["footnote"] = true,
	["citation"] = true,
	["verbatim"] = true,
	["listing"] = true,
	["frame"] = true,
	["block"] = true,
	["column"] = true,
	["columns"] = true,
	["tikzpicture"] = true,
	["axis"] = true,
	["scope"] = true,
	["pgfplot"] = true,
	["minipage"] = true,
	["subfigure"] = true,
	["subequation"] = true,
	["multline"] = true,
	["gather"] = true,
	["abstract"] = true,
	["bibliography"] = true,
	["appendix"] = true,
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
