-- lua/typewriter/init.lua
-- This plugin provides typewriter scrolling for neovim.

-- ~/.local/share/nvim/lazy/typewriter/lua/typewriter/init.lua

local api = vim.api

local typewriter_active = false

local config = {
	enable_with_zen_mode = true,
	enable_with_true_zen = true,
}

local function center_cursor()
	if not typewriter_active then
		return
	end

	-- Get the current cursor position
	local cursor = api.nvim_win_get_cursor(0)

	-- Center the screen around the cursor
	api.nvim_command("normal! zz")

	-- Restore the cursor position
	api.nvim_win_set_cursor(0, cursor)
end

local function enable_typewriter_mode()
	if not typewriter_active then
		typewriter_active = true
		-- Set autocommands for normal, insert, and visual modes
		api.nvim_command('autocmd CursorMoved,CursorMovedI * lua require("typewriter").center_cursor()')
		print("Typewriter mode enabled")
	end
end

local function disable_typewriter_mode()
	if typewriter_active then
		typewriter_active = false
		-- Clear the autocommand group for TypewriterMode
		api.nvim_command("autocmd! TypewriterMode")
		print("Typewriter mode disabled")
	end
end

local function toggle_typewriter_mode()
	if typewriter_active then
		disable_typewriter_mode()
	else
		enable_typewriter_mode()
	end
end

local function setup(user_config)
	if user_config then
		config = vim.tbl_extend("force", config, user_config)
	end

	api.nvim_command("augroup TypewriterMode")
	api.nvim_command("autocmd!")
	api.nvim_command("augroup END")

	api.nvim_create_user_command("TWEnable", enable_typewriter_mode, {})
	api.nvim_create_user_command("TWDisable", disable_typewriter_mode, {})
	api.nvim_create_user_command("TWToggle", toggle_typewriter_mode, {})

	if config.enable_with_zen_mode then
		api.nvim_command('autocmd User ZenModePre lua require("typewriter").enable()')
		api.nvim_command('autocmd User ZenModeLeave lua require("typewriter").disable()')
	end

	if config.enable_with_true_zen then
		api.nvim_command('autocmd User TZWoon lua require("typewriter").enable()')
		api.nvim_command('autocmd User TZOff lua require("typewriter").disable()')
	end
end

return {
	setup = setup,
	center_cursor = center_cursor,
	enable = enable_typewriter_mode,
	disable = disable_typewriter_mode,
	toggle = toggle_typewriter_mode,
}
