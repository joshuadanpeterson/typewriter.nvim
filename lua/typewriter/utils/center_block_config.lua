-- lua/typewriter/utils/center_block_config.lua
local M = {}

M.expand = {
	["function"] = true,
	["method"] = true,
	["table"] = true,
	["if_statement"] = true,
	["class"] = true,
	["block"] = true,
	["module"] = true,
	["namespace"] = true,
	["program"] = true,
	["source"] = true,
}

return M
