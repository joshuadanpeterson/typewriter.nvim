# Contributor Guidelines

## Testing and Linting
- Run Lua unit tests with `busted` when modifying Lua code. Install via LuaRocks if needed.
- Run `luacheck` for linting Lua files. You can install it with LuaRocks.
- You may skip tests and linting when changes only touch documentation or code comments.

## Commits
- Use **multi-line** Conventional Commits with an emoji prefix.
  Example:

  ```
  feat: 🚀 add new feature

  - implemented the core logic
  - updated documentation
  ```
