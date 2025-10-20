require('spec.spec_helper')

describe('typewriter.config', function()
  local config = require('typewriter.config')

  before_each(function()
    config.config = vim.tbl_extend('force', {}, config.default_config)
  end)

  it('returns default configuration by default', function()
    local cfg = config.get_config()
    assert.are.same(config.default_config, cfg)
    assert.is_false(cfg.always_center)
    assert.are.same({}, cfg.always_center_filetypes)
  end)

  it('merges user configuration correctly', function()
    config.config_setup({ enable_with_zen_mode = false, enable_notifications = false })
    local cfg = config.get_config()
    assert.is_false(cfg.enable_with_zen_mode)
    assert.is_false(cfg.enable_notifications)
    assert.is_false(cfg.always_center)
  end)

  it('vim.tbl_extend stub handles behaviour argument', function()
    local merged = vim.tbl_extend('force', { a = 1 }, { b = 2 })
    assert.are.same({ a = 1, b = 2 }, merged)
  end)
end)
