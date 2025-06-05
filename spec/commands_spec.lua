require("spec.spec_helper")

-- Stub treesitter utils to avoid requiring external dependency
package.loaded['nvim-treesitter.ts_utils'] = {
    get_node_at_cursor = function() return nil end
}

describe('typewriter.commands', function()
    local commands = require('typewriter.commands')
    local utils = require('typewriter.utils')

    before_each(function()
        utils.set_typewriter_active(true)
        vim.api.nvim_win_set_option = function(_, name, value)
            _G.wrap_option = { name, value }
        end
        vim.fn.winrestview = function(view)
            _G.leftcol = view.leftcol
        end
        vim.fn = vim.fn or {}
        vim.cmd = function() end
        utils.notify = function() end
        vim.api.nvim_clear_autocmds = function() end
    end)

    it('disable_typewriter_mode resets wrap and scroll', function()
        commands.disable_typewriter_mode()
        assert.are.same({ 'wrap', true }, _G.wrap_option)
        assert.are.equal(0, _G.leftcol)
    end)
end)
