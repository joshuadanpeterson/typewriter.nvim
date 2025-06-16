require('spec.spec_helper')

local logger = require('typewriter.logger')

-- Stub treesitter modules for tests that load the full plugin
package.loaded['nvim-treesitter.ts_utils'] = package.loaded['nvim-treesitter.ts_utils'] or {}
package.loaded['nvim-treesitter.parsers'] = package.loaded['nvim-treesitter.parsers'] or { get_buf_lang = function() return nil end }

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
  _G.created_autocmds = {}
  vim.api.nvim_create_autocmd = function(event, opts)
    table.insert(_G.created_autocmds, { event = event, callback = opts.callback })
  end
  vim.fn.mode = function() return 'n' end
  vim.v = { hlsearch = 1 }
  package.loaded['typewriter.autocommands'] = nil
  package.loaded['typewriter'] = nil
end)

after_each(function()
  _G.created_autocmds = nil
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

  it('writes warning messages to the log file', function()
    logger.warning('caution')
    local content = read_log()
    assert.is_not_nil(content:find('%[WARNING%] caution'))
  end)

  it('logs startup message when plugin initializes', function()
    local typewriter = require('typewriter')
    typewriter.setup()
    local content = read_log()
    assert.is_not_nil(content:find('Typewriter.nvim started'))
  end)

  it('logs fallback warning when regex search is used', function()
    local autocmd = nil
    require('typewriter.autocommands').autocmd_setup()
    for _, ac in ipairs(_G.created_autocmds) do
      if ac.event == 'CmdlineLeave' then
        autocmd = ac.callback
      end
    end
    vim.fn.getreg = function() return 'foo' end
    package.loaded['nvim-treesitter.parsers'] = { get_buf_lang = function() return nil end }
    vim.api.nvim_get_current_buf = function() return 1 end
    vim.api.nvim_buf_get_lines = function() return { 'foo' } end
    vim.api.nvim_win_set_cursor = function() end
    autocmd()
    local content = read_log()
    assert.is_not_nil(content:find('Falling back to regex'))
  end)

  it('logs shutdown message on VimLeavePre', function()
    local autocmd
    require('typewriter.autocommands').autocmd_setup()
    for _, ac in ipairs(_G.created_autocmds) do
      if ac.event == 'VimLeavePre' then autocmd = ac.callback end
    end
    autocmd()
    local content = read_log()
    assert.is_not_nil(content:find('Typewriter.nvim shutdown'))
  end)
end)
