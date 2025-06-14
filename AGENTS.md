# Project Agents.md Guide for OpenAI Codex

This Agents.md file provides guidance for OpenAI Codex and other AI agents working with this codebase.

## Project Structure for OpenAI Codex Navigation

- `/lua`: Source code for the Typewriter.nvim plugin
- `/doc`: Vim help documentation
- `/spec`: Busted unit tests
- `/demos`: Demo GIFs and images (do not modify)

## Coding Conventions for OpenAI Codex

- Use Lua for all plugin code
- Follow the existing code style in each file
- Provide meaningful variable and function names
- Add comments for complex logic

## Testing Requirements for OpenAI Codex

Run tests using the following command:

```bash
busted -v spec
```

Ensure tests pass before committing code changes. Documentation-only changes do not require running tests.

## Pull Request Guidelines for OpenAI Codex

1. Include a clear description of the changes
2. Reference related issues if applicable
3. Ensure tests pass
4. Keep PRs focused on a single concern

---
