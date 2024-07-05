-- lua/typewriter/utils.lua
-- Utility functions for Typewriter.nvim

local config = require("typewriter.config")

local M = {}

function M.notify(message)
	if config.config.enable_notifications then
		vim.notify(message, vim.log.levels.INFO)
	end
end

_G.center_cursor_horizontally = function()
	if not config.config.enable_horizontal_scroll then
		return
	end
	local win_width = vim.api.nvim_win_get_width(0)
	local cursor_col = vim.fn.virtcol(".")
	local left_col = math.max(cursor_col - math.floor(win_width / 2), 0) + 10
	vim.api.nvim_win_set_option(0, "wrap", false)
	vim.fn.winrestview({ leftcol = left_col })
end

return M
