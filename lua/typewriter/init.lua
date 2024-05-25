-- lua/typewriter/init.lua
-- This plugin provides typewriter scrolling for neovim.

-- ~/.local/share/nvim/lazy/typewriter/lua/typewriter/init.lua

local api = vim.api

local typewriter_active = false

local function center_cursor()
	if not typewriter_active then
		return
	end

	-- Center the screen around the cursor
	api.nvim_command("normal! zz")
end

local function enable_typewriter_mode()
	if not typewriter_active then
		typewriter_active = true
		api.nvim_command('autocmd CursorMoved * lua require("typewriter").center_cursor()')
		print("Typewriter mode enabled")
	end
end

local function disable_typewriter_mode()
	if typewriter_active then
		typewriter_active = false
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

local function setup()
	api.nvim_command("augroup TypewriterMode")
	api.nvim_command("autocmd!")
	api.nvim_command("augroup END")

	api.nvim_create_user_command("TWEnable", enable_typewriter_mode, {})
	api.nvim_create_user_command("TWDisable", disable_typewriter_mode, {})
	api.nvim_create_user_command("TWToggle", toggle_typewriter_mode, {})
end

return {
	setup = setup,
	center_cursor = center_cursor,
	enable = enable_typewriter_mode,
	disable = disable_typewriter_mode,
	toggle = toggle_typewriter_mode,
}
