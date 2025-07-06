require('spec.spec_helper')

describe('typewriter.autocommands scope', function()
  it('does not leak search helpers globally', function()
    package.loaded['nvim-treesitter.ts_utils'] = package.loaded['nvim-treesitter.ts_utils'] or {}
    package.loaded['nvim-treesitter.parsers'] = package.loaded['nvim-treesitter.parsers'] or { get_buf_lang = function() return nil end }
    package.loaded['typewriter.autocommands'] = nil
    require('typewriter.autocommands')
    assert.is_nil(_G.move_cursor_to_combined_match)
    assert.is_nil(_G.get_treesitter_match)
    assert.is_nil(_G.validate_position_with_lsp)
    assert.is_nil(_G.move_cursor_to_regex_match)
  end)
end)

describe('typewriter.autocommands search state', function()
  before_each(function()
    _G.created_autocmds = {}
    vim.api.nvim_create_autocmd = function(event, opts)
      table.insert(_G.created_autocmds, { event = event, callback = opts.callback })
    end
    vim.fn.mode = function() return 'n' end
    vim.v = { hlsearch = 1 }
    vim.fn.getreg = function() return 'foo' end
    vim.api.nvim_get_current_buf = function() return 1 end
    vim.api.nvim_buf_get_lines = function() return { 'foo' } end
    vim.api.nvim_win_set_cursor = function() end
    package.loaded['typewriter.autocommands'] = nil
  end)

  after_each(function()
    _G.created_autocmds = nil
  end)

  it('restores column preservation after search', function()
    local autocmds = require('typewriter.autocommands')
    local utils = require('typewriter.utils')

    autocmds.autocmd_setup()

    local enter_cb, leave_cb
    for _, ac in ipairs(_G.created_autocmds) do
      if ac.event == 'CmdlineEnter' then enter_cb = ac.callback end
      if ac.event == 'CmdlineLeave' then leave_cb = ac.callback end
    end

    utils.set_typewriter_active(true)
    autocmds.enable_column_preservation()
    local preserve_state = autocmds.get_state()

    enter_cb()
    leave_cb()

    assert.are.equal(preserve_state, autocmds.get_state())
  end)
end)
