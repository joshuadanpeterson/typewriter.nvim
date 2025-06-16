require('spec.spec_helper')

-- Stub treesitter modules to avoid require errors
package.loaded['nvim-treesitter.ts_utils'] = package.loaded['nvim-treesitter.ts_utils'] or {}
package.loaded['nvim-treesitter.parsers'] = package.loaded['nvim-treesitter.parsers'] or { get_buf_lang = function() return nil end }

local commands = require('typewriter.commands')
local utils = require('typewriter.utils')
local logger = require('typewriter.logger')

local log_path = logger.get_log_file()

local function read_log()
  local f = io.open(log_path, 'r')
  if not f then return '' end
  local content = f:read('*a')
  f:close()
  return content
end

before_each(function()
  os.remove(log_path)
  logger.set_log_file(log_path)
end)

after_each(function() end)

describe('typewriter.commands', function()
  it('enables and disables typewriter mode with logging', function()
    commands.enable_typewriter_mode()
    assert.is_true(utils.is_typewriter_active())
    commands.disable_typewriter_mode()
    assert.is_false(utils.is_typewriter_active())
    local content = read_log()
    assert.is_not_nil(content:find('Typewriter mode enabled'))
    assert.is_not_nil(content:find('Typewriter mode disabled'))
  end)
end)
