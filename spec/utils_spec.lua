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
end)
