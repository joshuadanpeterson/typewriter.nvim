--- Simple file-based logger for Typewriter.nvim
---
--- Provides basic functions to log info and error messages
--- to a file located in Neovim's stdpath('data') directory.

local log_file = vim.fn.stdpath('data') .. '/typewriter.log'

--- Append a log message to the log file, creating the directory if needed.
-- @param level string log level label
-- @param msg string message to write
local function write(level, msg)
  local dir = vim.fn.fnamemodify(log_file, ':h')
  -- Ensure the log directory exists to prevent failures on first run
  vim.fn.mkdir(dir, 'p')

  local ok, file = pcall(io.open, log_file, 'a')
  if ok and file then
    local line = string.format('%s [%s] %s\n', os.date('%Y-%m-%d %H:%M:%S'), level, msg)
    file:write(line)
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
