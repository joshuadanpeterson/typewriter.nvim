--- Simple file-based logger for Typewriter.nvim
---
--- Provides basic functions to log info and error messages
--- to a file located in Neovim's stdpath('data') directory.

local log_file = vim.fn.stdpath('data') .. '/typewriter.log'

local function write(level, msg)
  local ok, file = pcall(io.open, log_file, 'a')
  if ok and file then
    file:write(string.format('[%s] %s\n', level, msg))
    file:close()
  end
end

local M = {}

function M.info(msg)
  write('INFO', msg)
end

function M.error(msg)
  write('ERROR', msg)
end

return M
