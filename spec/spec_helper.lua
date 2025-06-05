package.path = package.path .. ';./lua/?.lua;./lua/?/init.lua'

-- Minimal vim stub for tests running outside Neovim
_G.vim = _G.vim or {}
vim.api = vim.api or {}
vim.api.nvim_exec_autocmds = vim.api.nvim_exec_autocmds or function() end
vim.fn = vim.fn or {}
vim.cmd = vim.cmd or function() end

return {}
