--- Tree-sitter compatibility helpers for Typewriter.nvim.
---
--- Prefer Neovim's built-in Tree-sitter API and fall back to legacy
--- nvim-treesitter.ts_utils when users are on older nvim-treesitter releases.

local M = {}

local function get_legacy_ts_utils()
	local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
	if ok then
		return ts_utils
	end
	return nil
end

local function get_legacy_parsers()
	local ok, parsers = pcall(require, "nvim-treesitter.parsers")
	if ok then
		return parsers
	end
	return nil
end

local function get_filetype(bufnr)
	if vim.api.nvim_get_option_value then
		local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = bufnr })
		if ok and ft ~= "" then
			return ft
		end
	end

	if vim.api.nvim_buf_get_option then
		local ok, ft = pcall(vim.api.nvim_buf_get_option, bufnr, "filetype")
		if ok and ft ~= "" then
			return ft
		end
	end

	return vim.bo.filetype
end

function M.get_buf_lang(bufnr)
	local parsers = get_legacy_parsers()
	if parsers and parsers.get_buf_lang then
		local ok, lang = pcall(parsers.get_buf_lang, bufnr)
		if ok and lang then
			return lang
		end
	end

	if vim.treesitter and vim.treesitter.language and vim.treesitter.language.get_lang then
		local ft = get_filetype(bufnr)
		if ft and ft ~= "" then
			return vim.treesitter.language.get_lang(ft)
		end
	end

	return nil
end

function M.get_node_at_cursor()
	if vim.treesitter and vim.treesitter.get_node then
		local ok, node = pcall(vim.treesitter.get_node, { bufnr = 0 })
		if ok and node then
			return node
		end
	end

	local ts_utils = get_legacy_ts_utils()
	if ts_utils and ts_utils.get_node_at_cursor then
		return ts_utils.get_node_at_cursor()
	end

	return nil
end

function M.get_root(bufnr)
	local lang = M.get_buf_lang(bufnr)
	if lang and vim.treesitter and vim.treesitter.get_parser then
		local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
		if ok and parser then
			local parsed, trees = pcall(parser.parse, parser)
			if parsed and trees and trees[1] then
				return trees[1]:root()
			end
		end
	end

	local ts_utils = get_legacy_ts_utils()
	if ts_utils and ts_utils.get_root_for_position then
		return ts_utils.get_root_for_position(0, 0, bufnr)
	end

	return nil
end

function M.get_node_text(node, bufnr)
	if vim.treesitter and vim.treesitter.get_node_text then
		local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
		if ok then
			return text
		end
	end

	local ts_utils = get_legacy_ts_utils()
	if ts_utils and ts_utils.get_node_text then
		local text = ts_utils.get_node_text(node, bufnr)
		if type(text) == "table" then
			return text[1]
		end
		return text
	end

	return nil
end

return M
