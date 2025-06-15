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
