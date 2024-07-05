-- lua/typewriter/config.lua
-- Configuration management for Typewriter.nvim

local M = {}

M.default_config = {
	enable_with_zen_mode = true,
	enable_with_true_zen = true,
	keep_cursor_position = true,
	enable_notifications = true,
	enable_horizontal_scroll = true,
}

M.config = M.default_config

function M.setup(user_config)
	if type(user_config) == "table" then
		M.config = vim.tbl_extend("force", M.config, user_config)
	end
end

return M
