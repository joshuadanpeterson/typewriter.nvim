<div align=center>
  <h1>Typewriter ✍️</h1>
</div>

<div align="center">
    <a href="https://dotfyle.com/plugins/joshuadanpeterson/typewriter.nvim">
      <img src="https://dotfyle.com/plugins/joshuadanpeterson/typewriter.nvim/shield?style=for-the-badge" alt="Dotfyle Plugin">
    </a>
    <a href="https://opensource.org/licenses/MIT">
      <img src="https://img.shields.io/badge/License-MIT-blue.svg?logo=open-source-initiative&style=for-the-badge" alt="License: MIT">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/releases">
      <img alt="GitHub Release Version" src="https://img.shields.io/github/v/release/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/releases">
      <img alt="GitHub Release Date" src="https://img.shields.io/github/release-date/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim">
      <img alt="GitHub Code Size" src="https://img.shields.io/github/languages/code-size/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/issues">
      <img alt="GitHub Issues" src="https://img.shields.io/github/issues/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge&color=darkblue">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/pulls">
      <img alt="GitHub Pull Requests" src="https://img.shields.io/github/issues-pr/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/commits">
      <img alt="GitHub Commits Since Latest Release" src="https://img.shields.io/github/commits-since/joshuadanpeterson/typewriter.nvim/latest?logo=github&style=for-the-badge">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim">
      <img alt="GitHub Language" src="https://img.shields.io/badge/lua-100000?style=for-the-badge&logo=lua&logoColor=white&label=language&color=purple">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/stargazers">
      <img alt="GitHub Stars" src="https://img.shields.io/github/stars/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge&color=gold">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/network/members">
      <img alt="GitHub Forks" src="https://img.shields.io/github/forks/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge&color=teal">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/graphs/contributors">
      <img alt="GitHub Contributors" src="https://img.shields.io/github/contributors/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge&color=lightgrey">
    </a>
    <a href="https://github.com/joshuadanpeterson/typewriter.nvim/commits">
      <img alt="GitHub Last Commit" src="https://img.shields.io/github/last-commit/joshuadanpeterson/typewriter.nvim?logo=github&style=for-the-badge&color=orange">
    </a>
</div>
</br>

A Neovim plugin that emulates a typewriter, keeping the cursor centered on the screen for a focused writing experience, and provides advanced code block navigation. 📝✨

<div align=center>
  <img src='./demos/demo.gif' height=500 width=600 title='Typewriter Demo'/>
</div>

## Features ✨

- Keeps the cursor centered on the screen while you type or navigate. 📌
- Simple commands to enable, disable, and toggle the typewriter mode. 🔄
- Integrates with ZenMode and True Zen for a seamless distraction-free environment. 🧘
- `:TWCenter` command to center the view around the current code block or function using [Tree-sitter](https://tree-sitter.github.io/tree-sitter/). 🌳
- `:TWTop` command to move the top of the current code block to the top of the screen. ⬆️
- `:TWBottom` command to move the bottom of the current code block to the bottom of the screen. ⬇️
- Set `keep_cursor_position` to `true` in plugin config to keep cursor position relative to text when centering the view or using TWTop/TWBottom. 📌
- Set `enable_notifications` to `true` in plugin config to enable or disable notifications for actions like enabling/disabling typewriter mode, and aligning code blocks. 🔔
- Enable horizontal scrolling in Typewriter mode and center the cursor by setting `enable_horizontal_scroll` to `true` in the plugin configuration. ↔️
- Robust state tracking with `is_typewriter_active()`, `set_typewriter_active()`, and `toggle_typewriter_active()` functions for programmatic control. 🎛️
- `TypewriterStateChanged` event for reacting to Typewriter mode state changes in your own scripts or plugins. 🔄
- Comprehensive in-editor help documentation accessible via `:help typewriter`. 📚

<div align=center>
  <h3>TWCenter Demo 🎥</h3>
  <img src='./demos/twcenter_demo.gif' height=500 width=700 title='TWCenter Demo'/>
</div>
<br></br>
<div align=center>
  <h3>TWTop/TWBottom Demo 🎥</h3>
  <img src='./demos/twtop_twbottom_demo.gif' height=500 width=700 title='TWTop/TWBottom Demo'/>
</div>
<br></br>
<div align=center>
  <h3>Horizontal Scrolling Demo 🎥</h3>
  <img src='./demos/horizontal_scrolling.gif' height=500 width=700 title='Horizontal Scrolling Demo'/>
</div>

## Installation 🔧

### Dependencies 📦

Typewriter requires the following dependencies:

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Typewriter uses Tree-sitter to determine the current code block or function for the `:TWCenter`, `:TWTop`, and `:TWBottom` commands.

Make sure to install and configure nvim-treesitter before using Typewriter.

### Using [Packer](https://github.com/wbthomason/packer.nvim)

Add the following to your Packer configuration:

```lua
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

```lua
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
| `:TWTop`     | Move the top of the current code block to the top of the screen             |
| `:TWBottom`  | Move the bottom of the current code block to the bottom of the screen       |

These commands allow you to control the typewriter mode in Neovim and navigate code blocks, enhancing your writing and coding experience by maintaining focus and reducing distractions. The `:TWCenter`, `:TWTop`, and `:TWBottom` commands leverage Tree-sitter to intelligently manipulate the view of your code blocks, providing a more focused and flexible coding experience.

## Supported Filetypes/Languages 🌐

Typewriter.nvim supports a variety of filetypes and languages, ensuring that your code navigation and centering experience is smooth across different programming environments. Below is a list of supported filetypes and languages. If you don't see your filetype listed, we still encourage you to download the plugin, as the common significant blocks section of the [center_block_config.lua](https://github.com/joshuadanpeterson/typewriter.nvim/blob/main/lua/typewriter/utils/center_block_config.lua) file supports many filetypes by default. If you download the plugin and it doesn't work as expected even with Treesitter installed and set up as a dependency, please open up an [issue](https://github.com/joshuadanpeterson/typewriter.nvim/issues).

- PHP
- Go
- Rust
- JavaScript
- Python
- HTML
- CSS
- Bash
- SQL
- YAML
- JSON
- Dart
- Swift
- C++
- C#
- C
- Zig
- OCaml
- Java

If you don't see your filetype supported, propose it via [issue](https://github.com/joshuadanpeterson/typewriter.nvim/issues) or a [pull request](https://github.com/joshuadanpeterson/typewriter.nvim/pulls)!

## [ZenMode and True Zen Configuration](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Integration-Guide)

### ZenMode 🧘

[ZenMode](https://github.com/folke/zen-mode.nvim) is a plugin for Neovim written by [folke](https://github.com/folke) that provides a distraction-free coding environment by opening the current buffer in a new full-screen floating window. It hides various UI elements, works well with other floating windows, and integrates with plugins like Telescope and gitsigns. Typewriter integrates with ZenMode to automatically enable typewriter mode when entering ZenMode and disable it when exiting.

### True Zen 🧘

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
                keep_cursor_position = true,
                enable_notifications = true,
                enable_horizontal_scroll = true,
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
                keep_cursor_position = true,
                enable_notifications = true,
                enable_horizontal_scroll = true,
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

## Documentation 📚

Typewriter.nvim now comes with comprehensive documentation to help you make the most of its features:

- **In-Editor Help**: Access detailed documentation directly in Neovim by running `:help typewriter`.
- **API Documentation**: For developers looking to integrate with Typewriter.nvim, check out our [API wiki article](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Typewriter.nvim-API).
- **State Tracking**: Learn about the new state tracking functionality in our [State Tracking wiki article](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/State-Tracking).

## Wiki 📚

- [Home: Overview](https://github.com/joshuadanpeterson/typewriter.nvim/wiki)
- [Commands](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Typewriter.nvim-Commands)
- [Demos](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Demos)
- [Enable Notifications](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Enable-Notifications)
- [Enabling Horizontal Scrolling](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Enabling-Horizontal-Scrolling)
- [Help Documentation](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Help-Documentation)
- [Installation Guide](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Installation-Guide)
- [Integration Guide](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Integration-Guide)
- [Media](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Media)
- [State Tracking](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/State-Tracking)
- [Tree‐sitter Integration for :TWCenter Command](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Tree%E2%80%90sitter-Integration-for-:TWCenter-Command)
- [TW `keep_cursor_position` Feature](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/TW-%60keep_cursor_position%60-Feature)
- [Typewriter.nvim API](https://github.com/joshuadanpeterson/typewriter.nvim/wiki/Typewriter.nvim-API)

## Inspiration 💡

This plugin was inspired by:

- [stay-centered.nvim](https://github.com/arnamak/stay-centered.nvim)
- [ZenMode](https://github.com/folke/zen-mode.nvim)
- [True Zen](https://github.com/pocco81/true-zen.nvim)
- [Twilight](https://github.com/folke/twilight.nvim)
- [Reddit comment by geckothegeek42](https://www.reddit.com/r/neovim/comments/1dg8myh/comment/l8pwg1a/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

## Credits 🙏

Special thanks to the following for their inspiration and ideas:

- The [Reddit post "Typewriter Scrolling"](https://www.reddit.com/r/neovim/comments/yhn7sc/typewriter_scrolling/).
- The [Obsidian plugin "Typewriter Mode"](https://github.com/davisriedel/obsidian-typewriter-mode).
- [JotterPad Typewriter Scrolling](https://help.jotterpad.app/en/article/typewriter-scrolling-1mb7vjz/)
- [Scrivener Typewriter Scrolling](https://scrivenerclasses.com/lesson/typewriter-scrolling/)

## License 📄

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing 🤝

Feel free to open up an [issue](https://github.com/joshuadanpeterson/typewriter.nvim/issues) or a [pull request](https://github.com/joshuadanpeterson/typewriter.nvim/pulls) to contribute to the project.
