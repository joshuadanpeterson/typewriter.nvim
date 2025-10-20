# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Structure

- `/lua`: Source code for the Typewriter.nvim plugin
- `/doc`: Vim help documentation
- `/spec`: Busted unit tests
- `/tests`: Additional test suites
- `/demos`: Demo GIFs and images (do not modify)
- `/.github/workflows`: CI/CD automation

## Common Development Commands

### Testing
```bash
# Run Busted tests with verbose output
busted -v spec/
# Or for tests directory
busted tests/

# Run luacheck for linting (install via LuaRocks if needed)
luacheck lua/

# Test the plugin locally in Neovim
nvim --headless +'lua require("typewriter").setup({ enable_horizontal_scroll = true })' +'autocmd BufEnter * normal! zt' +'qall'

# Quick local testing with your config
nvim -c "lua require('typewriter').setup()" test_file.lua
```

**Note**: Documentation-only changes do not require running tests.

### Dependency Management
```bash
# Install Tree-sitter parsers for supported languages
nvim -c "TSInstall php go rust javascript python html css bash sql yaml json dart swift cpp c_sharp c zig ocaml java"

# Update Tree-sitter parsers
nvim -c "TSUpdate"
```

### Release Process
The release workflow is automatically triggered on pushes to `main` or `dev` branches. It:
1. Runs Lua tests with Busted
2. Tests the plugin with Neovim
3. Determines version bump (major/minor/patch) based on conventional commits
4. Updates CHANGELOG.md automatically
5. Creates a GitHub release with appropriate tags

## Architecture Overview

### Module Structure
The plugin follows a modular architecture with clear separation of concerns:

```
lua/typewriter/
├── init.lua              # Entry point, setup function
├── commands.lua          # Core functionality (cursor centering, block navigation)
├── config.lua            # Configuration management
├── autocommands.lua      # Event handling and command registration
├── utils.lua             # Helper functions and state management
└── utils/
    └── center_block_config.lua  # Language-specific Tree-sitter node configurations
```

### Event-Driven System
- Uses Neovim's autocmd system for responsive behavior
- Key events: `CursorMoved`, `CursorMovedI` for typewriter mode
- Custom event: `TypewriterStateChanged` for external integrations
- Integrates with ZenMode and True Zen through their event callbacks

### State Management
- Global state tracking via `typewriter_active` variable
- Functions: `is_typewriter_active()`, `set_typewriter_active()`, `toggle_typewriter_active()`
- State persistence across mode changes and plugin reloads

### Tree-sitter Integration
The plugin uses Tree-sitter for intelligent code block detection:
- `center_block_config.lua` defines significant node types per language
- `commands.lua` traverses the syntax tree to find expandable blocks
- Supports 19+ programming languages with specific node configurations

## Key Components and Dependencies

### Core Dependencies
- **nvim-treesitter**: Required for code block detection and navigation
- **Neovim 0.5+**: Minimum version for Tree-sitter support

### Module Interactions
1. `init.lua` loads config and autocommands during setup
2. `autocommands.lua` creates user commands that call functions in `commands.lua`
3. `commands.lua` uses `utils.lua` for helper functions and `center_block_config.lua` for node detection
4. `config.lua` provides centralized configuration accessed by all modules

### Command Flow Example
```
User runs :TWCenter
  → autocommands.lua command handler
    → commands.center_block_and_cursor()
      → ts_utils.get_node_at_cursor()
      → center_block_config.should_expand()
      → Cursor positioning and view adjustment
      → utils.notify() for user feedback
```

## Development Workflow

### Local Development Setup
```bash
# Clone to Neovim plugin directory for testing
mkdir -p ~/.local/share/nvim/site/pack/test/start/
cd ~/.local/share/nvim/site/pack/test/start/
ln -s /path/to/typewriter .

# Test with minimal config
nvim -u NONE -c "lua require('typewriter').setup()" test.lua
```

### Branch Strategy
- `main`: Stable releases
- `dev`: Development and feature branches
- Feature branches merge into `dev`, then `dev` merges to `main` for releases

### Commit Convention
Uses multi-line conventional commits with emojis:
```bash
# Format: type(scope): emoji description
# Followed by bullet points for details

git commit -m "feat(commands): ✨ Add support for TypeScript blocks

- Implemented core logic for TypeScript nodes
- Updated center_block_config.lua
- Added test coverage"

git commit -m "fix(autocommands): 🐛 Resolve cursor position issue

- Fixed column preservation logic
- Updated autocommand handlers"

git commit -m "docs(README): 📚 Update installation instructions

- Added Lazy.nvim setup example
- Clarified dependencies"
```

### Adding Language Support
To add support for a new language:
1. Identify significant Tree-sitter node types for the language
2. Add them to `lua/typewriter/utils/center_block_config.lua`
3. Test with sample code files
4. Update README.md supported languages section
5. Run tests to ensure no regressions

### Pull Request Guidelines
1. Include a clear description of the changes
2. Reference related issues if applicable (e.g., "Fixes #123")
3. Ensure all tests pass (`busted -v spec/`)
4. Keep PRs focused on a single concern
5. Follow the existing code style in each file

## Coding Conventions

- Use Lua for all plugin code
- Follow the existing code style in each file
- Provide meaningful variable and function names
- Add comments for complex logic
- Run `luacheck` for linting before committing
- Ensure tests pass before committing code changes

## Technical Details

### Configuration Options
```lua
{
  enable_with_zen_mode = true,      -- Auto-enable with ZenMode
  enable_with_true_zen = true,      -- Auto-enable with True Zen
  keep_cursor_position = true,      -- Maintain cursor position when centering
  enable_notifications = true,       -- Show action notifications
  enable_horizontal_scroll = true   -- Center horizontally as well
}
```

### Performance Considerations
- Cursor centering uses `normal! zz` for efficiency
- Horizontal centering is optional due to performance impact
- Tree-sitter node traversal is limited to parent hierarchy
- Redraw forcing with `vim.api.nvim_command('redraw')` ensures visual updates

### Code Block Detection Algorithm
1. Get Tree-sitter node at cursor position
2. Traverse up the syntax tree to find significant parent nodes
3. Check node type against `center_block_config.expand` table
4. Return the highest significant ancestor node
5. Calculate block boundaries and center appropriately

## Troubleshooting

### Common Issues

**Tree-sitter parser not found**
```bash
# Check installed parsers
:TSInstallInfo

# Install missing parser
:TSInstall <language>
```

**Typewriter mode not activating**
```lua
-- Check state programmatically
:lua print(require("typewriter.utils").is_typewriter_active())

-- Verify autocmds are registered
:autocmd TypewriterMode
```

**Block centering not working for specific language**
1. Verify Tree-sitter parser is installed
2. Check if language nodes are in `center_block_config.lua`
3. Use `:InspectTree` to identify node types at cursor

### Debug Commands
```vim
" Check current plugin state
:lua print(vim.inspect(require("typewriter.config").get_config()))

" Test specific functions
:lua require("typewriter.commands").center_cursor()
:lua require("typewriter.commands").center_block_and_cursor()

" Inspect Tree-sitter node at cursor
:lua print(require("nvim-treesitter.ts_utils").get_node_at_cursor():type())
```

## Integration Examples

### With ZenMode
```lua
require('zen-mode').setup({
  on_open = function()
    vim.cmd('TWEnable')
  end,
  on_close = function()
    vim.cmd('TWDisable')
  end
})
```

### Custom Keybindings
```lua
vim.keymap.set('n', '<leader>tw', ':TWToggle<CR>', { desc = 'Toggle typewriter mode' })
vim.keymap.set('n', '<leader>tc', ':TWCenter<CR>', { desc = 'Center code block' })
vim.keymap.set('n', '<leader>tt', ':TWTop<CR>', { desc = 'Block to top' })
vim.keymap.set('n', '<leader>tb', ':TWBottom<CR>', { desc = 'Block to bottom' })
```

### Reacting to State Changes
```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "TypewriterStateChanged",
  callback = function()
    local active = require("typewriter.utils").is_typewriter_active()
    vim.notify("Typewriter: " .. (active and "ON" or "OFF"))
  end
})
```

## Related Documentation

- [README.md](README.md) - Full feature list and installation guide
- [CHANGELOG.md](CHANGELOG.md) - Version history and changes
- [doc/typewriter.txt](doc/typewriter.txt) - In-editor help (`:help typewriter`)
- [GitHub Wiki](https://github.com/joshuadanpeterson/typewriter.nvim/wiki) - Extended documentation
- [Release Workflow](.github/workflows/release.yml) - CI/CD configuration
