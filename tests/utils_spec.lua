require('spec.spec_helper')

local utils = require('typewriter.utils')

describe('create_escaped_regex_pattern', function()
  it('escapes special characters and wraps in word boundaries', function()
    local pattern = 'foo+bar?'
    local regex = utils.create_escaped_regex_pattern(pattern)
    assert.are.same("\\bfoo%+bar%?\\b", regex)
  end)
end)
