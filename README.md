# Typewriter

<a href="https://dotfyle.com/plugins/joshuadanpeterson/typewriter.nvim">
  <img src="https://dotfyle.com/plugins/joshuadanpeterson/typewriter.nvim/shield" />
</a>

A Neovim plugin that emulates a typewriter, keeping the cursor centered on the screen for a focused writing experience.

<div align=center>
<img src='./demos/demo.gif' height=500 width=500 title='Typewriter Demo'/>
</div>

## Features

- Keeps the cursor centered on the screen while you type or navigate.
- Simple commands to enable, disable, and toggle the typewriter mode.
- Integrates with ZenMode and True Zen for a seamless distraction-free environment.

## Installation

### Using [Packer](https://github.com/wbthomason/packer.nvim)

Add the following to your Packer configuration:

```lua
use {
    'joshuadanpeterson/typewriter',
    config = function()
        require('typewriter').setup()
    end
}
```

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

Add the following to your Lazy.nvim configuration:

```lua
local lazy = require('lazy')

lazy.setup({
    -- Other plugins...

    {
        'joshuadanpeterson/typewriter',
        config = function()
            require('typewriter').setup()
        end,
        opts = {}
    },
})
```

## Commands

| Command      | Description                        |
| ------------ | ---------------------------------- |
| `:TWEnable`  | Enable typewriter mode.            |
| `:TWDisable` | Disable typewriter mode.           |
| `:TWToggle`  | Toggle typewriter mode on and off. |

## Usage

1. Add the plugin to your Neovim configuration as shown in the installation section.
2. Reload Neovim or restart it.
3. Use the provided commands to control the typewriter mode.

## Example Configuration

### Packer

```lua
-- ~/.config/nvim/init.lua

require('packer').startup(function()
    -- Other plugins...

    use {
        'joshuadanpeterson/typewriter',
        config = function()
            require('typewriter').setup({
                enable_with_zen_mode = true,
                enable_with_true_zen = true,
            })
        end
    }

    use {
        'folke/zen-mode.nvim',
        opts = {
            on_open = function()
                vim.cmd('TWEnable')
            end,
            on_close = function()
                vim.cmd('TWDisable')
            end
        }
    }

    use {
        'pocco81/true-zen.nvim',
        config = function()
            require("true-zen").setup {
                modes = {
                    ataraxis = {
                        callbacks = {
                            open_pre = function()
                                vim.cmd('TWEnable')
                            end,
                            close_pos = function()
                                vim.cmd('TWDisable')
                            end
                        }
                    }
                }
            }
        end
    }
end)
```

### Lazy.nvim

```lua
-- ~/.config/nvim/lua/plugins/init.lua

local lazy = require('lazy')

lazy.setup({
    -- Other plugins...

    {
        'joshuadanpeterson/typewriter',
        config = function()
            require('typewriter').setup({
                enable_with_zen_mode = true,
                enable_with_true_zen = true,
            })
        end,
        opts = {}
    },

    {
        'folke/zen-mode.nvim',
        opts = {
            on_open = function()
                vim.cmd('TWEnable')
            end,
            on_close = function()
                vim.cmd('TWDisable')
            end
        }
    },

    {
        'pocco81/true-zen.nvim',
        config = function()
            require("true-zen").setup {
                modes = {
                    ataraxis = {
                        callbacks = {
                            open_pre = function()
                                vim.cmd('TWEnable')
                            end,
                            close_pos = function()
                                vim.cmd('TWDisable')
                            end
                        }
                    }
                }
            }
        end,
        opts = {}
    }
})
```

## Integration with ZenMode and True Zen

### ZenMode

[ZenMode](https://github.com/folke/zen-mode.nvim) is a plugin for Neovim written by [folke](https://github.com/folke) that provides a distraction-free coding environment by opening the current buffer in a new full-screen floating window. It hides various UI elements, works well with other floating windows, and integrates with plugins like Telescope and gitsigns. Typewriter integrates with ZenMode to automatically enable typewriter mode when entering ZenMode and disable it when exiting.

### True Zen

[True Zen](https://github.com/pocco81/true-zen.nvim) is another plugin for Neovim written by [pocco81](https://github.com/pocco81) that offers multiple modes to unclutter your screen, including Ataraxis (a zen mode), Minimalist, Narrow, and Focus. True Zen allows you to disable UI components, narrow a text region for better focus, and customize callbacks for each mode. Typewriter integrates with True Zen, particularly the Ataraxis mode, to automatically enable typewriter mode when entering Ataraxis and disable it when exiting.

## Inspiration

This plugin was inspired by:

- [stay-centered.nvim](https://github.com/arnamak/stay-centered.nvim)
- [ZenMode](https://github.com/folke/zen-mode.nvim)
- [True Zen](https://github.com/pocco81/true-zen.nvim)
- [Twilight](https://github.com/folke/twilight.nvim)

## Credits

Special thanks to the following for their inspiration and ideas:

- The [Reddit post "Typewriter Scrolling"](https://www.reddit.com/r/neovim/comments/yhn7sc/typewriter_scrolling/).
- The [Obsidian plugin "Typewriter Mode"](https://github.com/davisriedel/obsidian-typewriter-mode).
- [JotterPad Typewriter Scrolling](https://help.jotterpad.app/en/article/typewriter-scrolling-1mb7vjz/)
- [Scrivener Typewriter Scrolling](https://scrivenerclasses.com/lesson/typewriter-scrolling/)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
