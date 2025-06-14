require("spec.spec_helper")
describe('typewriter.utils', function()
  local utils = require('typewriter.utils')

  before_each(function()
    utils.set_typewriter_active(false)
  end)

  it('is_typewriter_active() defaults to false', function()
    assert.is_false(utils.is_typewriter_active())
  end)

  it('toggle_typewriter_active() toggles state', function()
    local state = utils.toggle_typewriter_active()
    assert.is_true(state)
    assert.is_true(utils.is_typewriter_active())
  end)
  
  it('center_cursor_horizontally adjusts view and redraws', function()
      vim.api.nvim_win_get_width = function() return 80 end
      vim.fn.virtcol = function() return 40 end
      vim.api.nvim_win_set_option = function(_, name, value)
      _G.hopt = { name, value }
      end
      vim.fn.winrestview = function(view)
      _G.hleft = view.leftcol
      end
      vim.cmd = function(cmd) _G.last_cmd = cmd end
      utils.center_cursor_horizontally()
      assert.are.same({ 'wrap', false }, _G.hopt)
      assert.are.equal(10, _G.hleft)
      assert.are.equal('redraw', _G.last_cmd)
  end)
end)
