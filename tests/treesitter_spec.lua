require('spec.spec_helper')

describe('typewriter.treesitter compatibility', function()
  before_each(function()
    package.loaded['typewriter.treesitter'] = nil
    package.loaded['typewriter.commands'] = nil
    package.loaded['typewriter.autocommands'] = nil
    package.loaded['nvim-treesitter.ts_utils'] = nil
  end)

  it('loads commands without legacy nvim-treesitter.ts_utils', function()
    local original_require = require
    _G.require = function(name)
      if name == 'nvim-treesitter.ts_utils' then
        error("module 'nvim-treesitter.ts_utils' not found")
      end
      return original_require(name)
    end

    local ok, commands = pcall(original_require, 'typewriter.commands')

    _G.require = original_require

    assert.is_true(ok)
    assert.is_table(commands)
  end)

  it('falls back to legacy ts_utils when core get_node is unavailable', function()
    local legacy_node = { type = function() return 'function' end }
    package.loaded['nvim-treesitter.ts_utils'] = {
      get_node_at_cursor = function()
        return legacy_node
      end,
    }

    local original_treesitter = vim.treesitter
    vim.treesitter = {}

    local treesitter = require('typewriter.treesitter')

    assert.are.equal(legacy_node, treesitter.get_node_at_cursor())

    vim.treesitter = original_treesitter
  end)
end)
