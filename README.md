# Typewriter

A Neovim plugin that emulates a typewriter, keeping the cursor centered on the screen for a focused writing experience.

## Features

- Keeps the cursor centered on the screen while you type or navigate.
- Simple commands to enable, disable, and toggle the typewriter mode.

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
            require('typewriter').setup()
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
            require('typewriter').setup()
        end,
        opts = {}
    },
})
```

## Inspiration

This plugin was inspired by:

- [stay-centered.nvim](https://github.com/arnamak/stay-centered.nvim)
- [ZenMode](https://github.com/folke/zen-mode.nvim)
- [True Zen](https://github.com/pocco81/true-zen.nvim)
- [Twilight](https://github.com/folke/twilight.nvim)

## Credits

Special thanks to the following for their inspiration and ideas:

The [Reddit post "Typewriter Scrolling"](https://www.reddit.com/r/neovim/comments/yhn7sc/typewriter_scrolling/) for the initial idea.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
