require('spec.spec_helper')

local logger = require('typewriter.logger')

local log_path = '/tmp/typewriter.log'

local function read_log()
  local f = io.open(log_path, 'r')
  if not f then return '' end
  local content = f:read('*a')
  f:close()
  return content
end

before_each(function()
  os.remove(log_path)
end)

describe('typewriter.logger', function()
  it('writes info messages to the log file', function()
    logger.info('hello')
    local content = read_log()
    assert.is_not_nil(content:find('%[INFO%] hello'))
  end)

  it('writes error messages to the log file', function()
    logger.error('bad')
    local content = read_log()
    assert.is_not_nil(content:find('%[ERROR%] bad'))
  end)
end)
