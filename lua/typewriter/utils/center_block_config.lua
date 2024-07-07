--- Configuration for significant code blocks to center in Typewriter.nvim
---
--- This module defines the types of code blocks that should be centered in Typewriter.nvim.
---
--- @module typewriter.utils.center_block_config
--- @file lua/typewriter/utils/center_block_config.lua
--- @tag typewriter-center-block-config

local M = {}

--- Table indicating which code blocks should be expanded and centered
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
}

return M
