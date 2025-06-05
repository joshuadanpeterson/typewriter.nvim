# Project Agents.md Guide for OpenAI Codex

This Agents.md file provides comprehensive guidance for OpenAI Codex and other AI agents working with this codebase.

## Project Structure for OpenAI Codex Navigation

- `lua/`: Lua source files for the plugin
- `doc/`: help documentation
- `spec/`: Busted unit tests
- `demos/`: demonstration scripts

## Coding Conventions for OpenAI Codex

- Use **tab-based indentation**.
- Write comments in **LuaDoc** style with triple dashes (`---`).
- Prefer **snake_case** for function and variable names.
- Ensure a newline at the end of every file.

## Testing Requirements for OpenAI Codex

Run the following commands for Lua changes (skip when only docs or comments are modified):

```bash
luacheck .
busted
```

## Pull Request Guidelines for OpenAI Codex

- Use multi-line Conventional Commits with emoji prefixes for all commits.

## Programmatic Checks for OpenAI Codex

Before opening a Pull Request, make sure all required tests and linters pass.
