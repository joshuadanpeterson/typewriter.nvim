package.path = package.path .. ';./lua/?.lua;./lua/?/init.lua'

-- Minimal vim stub for tests running outside Neovim
_G.vim = _G.vim or {}
vim.api = vim.api or {}
vim.fn = vim.fn or {}
vim.api.nvim_exec_autocmds = vim.api.nvim_exec_autocmds or function() end
vim.api.nvim_win_set_cursor = vim.api.nvim_win_set_cursor or function() end
vim.api.nvim_win_get_cursor = vim.api.nvim_win_get_cursor or function() return {1,0} end
vim.cmd = vim.cmd or function() end
vim.schedule = vim.schedule or function(fn) fn() end
vim.log = vim.log or { levels = { INFO = 1 } }
vim.notify = vim.notify or function() end
vim.fn.stdpath = vim.fn.stdpath or function() return '/tmp' end
vim.fn.fnamemodify = vim.fn.fnamemodify or function(path, mod)
  if mod == ':h' then
    return path:match('(.+)/[^/]*$') or '.'
  end
  return path
end
vim.fn.mkdir = vim.fn.mkdir or function() end
vim.tbl_extend = vim.tbl_extend or function(_, ...)
  local result = {}
  -- Use pairs to iterate over the provided tables so keys of any type
  -- are copied, matching the behaviour of real vim.tbl_extend.
  for _, t in pairs{...} do
    if type(t) == "table" then
      for k, v in pairs(t) do
        result[k] = v
      end
    end
  end
  return result
end
return {}
