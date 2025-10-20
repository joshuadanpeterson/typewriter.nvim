require('spec.spec_helper')

describe('typewriter.commands cursor restoration', function()
  local ts_utils = {}
  package.loaded['nvim-treesitter.ts_utils'] = ts_utils
  local commands = require('typewriter.commands')
  local config = require('typewriter.config')

  local last_set_cursor

  before_each(function()
    ts_utils.get_node_at_cursor = function()
      return {
        type = function() return 'function' end,
        range = function() return 10, 0, 20, 0 end,
        parent = function() return nil end,
      }
    end
    last_set_cursor = nil
    vim.api.nvim_win_get_cursor = function() return {12, 5} end
    vim.api.nvim_win_set_cursor = function(_, pos) last_set_cursor = pos end
    config.config.keep_cursor_position = true
  end)

  it('restores cursor position with TWTop', function()
    commands.move_to_top_of_block()
    assert.same({12, 5}, last_set_cursor)
  end)

  it('restores cursor position with TWBottom', function()
    commands.move_to_bottom_of_block()
    assert.same({12, 5}, last_set_cursor)
  end)
end)
