package.path = package.path .. ';./lua/?.lua;./lua/?/init.lua'

-- Minimal vim stub for tests running outside Neovim
_G.vim = _G.vim or {}
vim.api = vim.api or {}
vim.api.nvim_exec_autocmds = vim.api.nvim_exec_autocmds or function() end
vim.api.nvim_win_set_cursor = vim.api.nvim_win_set_cursor or function() end
vim.api.nvim_win_get_cursor = vim.api.nvim_win_get_cursor or function() return {1,0} end
vim.cmd = vim.cmd or function() end
vim.schedule = vim.schedule or function(fn) fn() end
vim.log = vim.log or { levels = { INFO = 1 } }
vim.notify = vim.notify or function() end

return {}
