--- Simple file-based logger for Typewriter.nvim
---
--- Provides basic functions to log info, warning, and error messages
--- to a file located in Neovim's stdpath('data') directory.

local log_file = vim.fn.stdpath('data') .. '/typewriter.log'

local M = {}

--- Set a custom log file path
--
-- Allows tests or users to override the default location.
-- The directory of the provided path will be created automatically
-- when writing messages.
-- @param path string new log file path
function M.set_log_file(path)
  log_file = path
end

--- Get the current log file path
-- @return string
function M.get_log_file()
  return log_file
end


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

function M.info(msg)
  write('INFO', msg)
end

function M.warning(msg)
  write('WARNING', msg)
end

function M.error(msg)
  write('ERROR', msg)
end

return M
