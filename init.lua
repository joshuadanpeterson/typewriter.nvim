-- typewriter/init.lua
-- This plugin provides typewriter scrolling for neovim.

local typewriter = {}

local typewriter_active = false

local function center_cursor()
	if not typewriter_active then
		return
	end
	local win_height = vim.api.nvim_win_get_height(0)
	local cursor = vim.api.nvim_win_get_cursor(0)

	local new_row = math.floor(win_height / 2)
	local new_col = cursor[2]

	vim.api.nvim_win_set_cursor(0, { new_row, new_col })
	vim.api.nvim_command("normal! zz")
end

local function enable_typewriter_mode()
	if not typewriter_active then
		typewriter_active = true
		vim.api.nvim_command('autocmd CursorMoved * lua require("typewriter").center_cursor()')
		print("Typewriter mode enabled")
	end
end

local function disable_typewriter_mode()
	if typewriter_active then
		typewriter_active = false
		vim.api.nvim_command("autocmd! TypewriterMode")
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

function typewriter.setup()
	vim.api.nvim_command("augroup TypewriterMode")
	vim.api.nvim_command("autocmd!")
	vim.api.nvim_command("augroup END")

	vim.api.nvim_create_user_command("EnableTypewriter", enable_typewriter_mode, {})
	vim.api.nvim_create_user_command("DisableTypewriter", disable_typewriter_mode, {})
	vim.api.nvim_create_user_command("ToggleTypewriter", toggle_typewriter_mode, {})
end

return typewriter
