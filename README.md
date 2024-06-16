# Typewriter

<a href="https://dotfyle.com/plugins/joshuadanpeterson/typewriter.nvim">
  <img src="https://dotfyle.com/plugins/joshuadanpeterson/typewriter.nvim/shield" />
</a>

A Neovim plugin that emulates a typewriter, keeping the cursor centered on the screen for a focused writing experience.

<div align=center>
<img src='./demos/demo.gif' height=500 width=600 title='Typewriter Demo'/>
</div>

## Features

- Keeps the cursor centered on the screen while you type or navigate.
- Simple commands to enable, disable, and toggle the typewriter mode.
- Integrates with ZenMode and True Zen for a seamless distraction-free environment.
- New `:TWCenter` command to center the view around the current code block or function using [Tree-sitter](https://tree-sitter.github.io/tree-sitter/).

<div align=center>
<img src='./demos/twcenter_demo.gif' height=500 width=700 title='Typewriter Demo'/>
</div>

## Installation

### Dependencies

Typewriter requires the following dependencies:

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Typewriter uses Tree-sitter to determine the current code block or function for the `:TWCenter` command.

Make sure to install and configure nvim-treesitter before using Typewriter.

### Using [Packer](https://github.com/wbthomason/packer.nvim)

Add the following to your Packer configuration:

```
use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
}

use {
    'joshuadanpeterson/typewriter',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
        require('typewriter').setup()
    end
}
```

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

Add the following to your Lazy.nvim configuration:

```
local lazy = require('lazy')

lazy.setup({
    -- Other plugins...

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

    {
        'joshuadanpeterson/typewriter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('typewriter').setup()
        end,
        opts = {}
    },
})
```

## [Commands](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Typewriter.nvim-Commands)

Here is a markdown table that summarizes the commands available in Typewriter.nvim:

| Command      | Description                                                                 |
| ------------ | --------------------------------------------------------------------------- |
| `:TWEnable`  | Enable typewriter mode                                                      |
| `:TWDisable` | Disable typewriter mode                                                     |
| `:TWToggle`  | Toggle typewriter mode on and off                                           |
| `:TWCenter`  | Center the view around the current code block or function using Tree-sitter |

These commands allow you to control the typewriter mode in Neovim, enhancing your writing and coding experience by maintaining focus and reducing distractions. The new `:TWCenter` command leverages Tree-sitter to intelligently center the view around the current code block or function, providing a more focused view of your code.

## [ZenMode and True Zen Configuration](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Integration-Guide)

### ZenMode

[ZenMode](https://github.com/folke/zen-mode.nvim) is a plugin for Neovim written by [folke](https://github.com/folke) that provides a distraction-free coding environment by opening the current buffer in a new full-screen floating window. It hides various UI elements, works well with other floating windows, and integrates with plugins like Telescope and gitsigns. Typewriter integrates with ZenMode to automatically enable typewriter mode when entering ZenMode and disable it when exiting.

### True Zen

[True Zen](https://github.com/pocco81/true-zen.nvim) is another plugin for Neovim written by [pocco81](https://github.com/pocco81) that offers multiple modes to unclutter your screen, including Ataraxis (a zen mode), Minimalist, Narrow, and Focus. True Zen allows you to disable UI components, narrow a text region for better focus, and customize callbacks for each mode. Typewriter integrates with True Zen, particularly the Ataraxis mode, to automatically enable typewriter mode when entering Ataraxis and disable it when exiting.

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

## Inspiration

This plugin was inspired by:

- [stay-centered.nvim](https://github.com/arnamak/stay-centered.nvim)
- [ZenMode](https://github.com/folke/zen-mode.nvim)
- [True Zen](https://github.com/pocco81/true-zen.nvim)
- [Twilight](https://github.com/folke/twilight.nvim)
- [Reddit comment by geckothegeek42](https://www.reddit.com/r/neovim/comments/1dg8myh/comment/l8pwg1a/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

## Credits

Special thanks to the following for their inspiration and ideas:

- The [Reddit post "Typewriter Scrolling"](https://www.reddit.com/r/neovim/comments/yhn7sc/typewriter_scrolling/).
- The [Obsidian plugin "Typewriter Mode"](https://github.com/davisriedel/obsidian-typewriter-mode).
- [JotterPad Typewriter Scrolling](https://help.jotterpad.app/en/article/typewriter-scrolling-1mb7vjz/)
- [Scrivener Typewriter Scrolling](https://scrivenerclasses.com/lesson/typewriter-scrolling/)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to open up an [issue](https://github.com/joshuadanpeterson/typewriter.nvim/issues) or a [pull request](https://github.com/joshuadanpeterson/typewriter.nvim/pulls) to contribute to the project.
