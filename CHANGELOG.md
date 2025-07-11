# Changelog

## [v0.7.4](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.7.4) (2025-07-05)
- Merge pull request #45 from joshuadanpeterson/codex/fix-issue-#44
- fix(autocommands): 🛠️ restore column preservation
- docs: update CHANGELOG.md for v0.7.3 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.7.3...v0.7.4)

## [v0.7.3](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.7.3) (2025-06-19)
- Merge pull request #43 from joshuadanpeterson/codex/fix-issue-#42-based-on-suggestion
- test: 🧪 restore filetype in commands test
- docs: 📝 clarify trailing comma usage
- docs: 📝 fix setup examples in help
- docs: \xF0\x9F\x93\x9D fix missing trailing comma in config examples
- feat(config): ✨ add always_center option
- docs: update CHANGELOG.md for v0.7.2 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.7.4...v0.7.3)

## [v0.7.2](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.7.2) (2025-06-16)
- Merge pull request #41 from joshuadanpeterson/codex/fix-issue-#30
- test: ✅ verify center_cursor uses zz in middle\n\n- add test for non-edge cursor\n- ensures fix for issue #30
- docs: update CHANGELOG.md for v0.7.1 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.7.3...v0.7.2)

## [v0.7.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.7.1) (2025-06-16)
- Merge pull request #40 from joshuadanpeterson/codex/fix-issue-#29
- feat(config): ✨ add start_enabled option
- docs: update CHANGELOG.md for v0.7.0 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.7.2...v0.7.1)

## [v0.7.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.7.0) (2025-06-16)
- Merge pull request #39 from joshuadanpeterson/codex/create-tests-folder-and-add-tests
- feat: 🔍 add regex helper and tests
- fix: 🔒 enforce local helper scope
- refactor: ♻️ scope search helpers locally
- feat: 🧪 extend logger API and tests
- feat: ⚠️ add warning log level
- fix(logger): 🪵 improve reliability
- feat: 📝 add shutdown logging and logger tests
- feat: 🧪 add logging and tests
- Merge pull request #38 from joshuadanpeterson/codex/fix-issue-#28
- Merge branch 'main' into codex/fix-issue-#28
- fix(commands): 🎯 correct cursor restoration
- fix(commands): correct cursor restoration
- docs: update CHANGELOG.md for v0.6.19 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.7.1...v0.7.0)

## [v0.6.28](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.28) (2025-06-16)
- feat: extract regex escaping to shared helper
- test: add utils and command specs for broader coverage

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.7.0...v0.6.28)

## [v0.6.26](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.26) (2025-06-15)
- refactor: limit helper function scope to avoid global pollution

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.28...v0.6.26)

## [v0.6.27](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.27) (2025-06-15)
- fix: ensure search helpers remain local
- test: verify no global leakage

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.26...v0.6.27)

## [v0.6.25](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.25) (2025-06-15)
- feat: allow custom log file path and document usage
- test: cover startup, fallback, and shutdown logging

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.27...v0.6.25)

## [v0.6.24](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.24) (2025-06-15)
- feat: add warning log level and use it for regex fallback
- test: ensure warning messages are written

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.25...v0.6.24)

## [v0.6.23](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.23) (2025-06-15)
- fix: ensure log directory exists and timestamp entries
- test: cover vim.tbl_extend behaviour

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.24...v0.6.23)

## [v0.6.22](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.22) (2025-06-15)
- feat: log plugin shutdown on VimLeavePre
- test: add logger specs

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.23...v0.6.22)

## [v0.6.21](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.21) (2025-06-15)
- feat: add logging utilities and tests
- docs: document logging feature

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.22...v0.6.21)

## [v0.6.20](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.20) (2025-06-14)
- fix: restore cursor correctly when using TWTop or TWBottom

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.21...v0.6.20)

## [v0.6.19](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.19) (2025-06-05)
- Merge pull request #37 from joshuadanpeterson/codex/fix-issue-#27
- fix: 🐛 resolve ghosting issue and improve docs
- fix: 🐛 resolve ghosting issue
- docs: update CHANGELOG.md for v0.6.18 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.20...v0.6.19)

## [v0.6.18](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.18) (2025-06-05)
- Update README.md
- docs: update CHANGELOG.md for v0.6.17 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.19...v0.6.18)

## [v0.6.17](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.17) (2025-06-05)
- Merge pull request #35 from joshuadanpeterson/codex/update-agents.md-with-new-sections-and-conventions
- Merge branch 'main' into codex/update-agents.md-with-new-sections-and-conventions
- ✨ docs: add AGENTS usage guide
- docs: update CHANGELOG.md for v0.6.16 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.18...v0.6.17)

## [v0.6.16](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.16) (2025-06-04)
- Merge pull request #34 from joshuadanpeterson/codex/create-agents.md-file
- docs: ✏️ clarify commit guidelines
- docs: update CHANGELOG.md for v0.6.15 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.17...v0.6.16)

## [v0.6.15](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.15) (2025-06-04)
- Merge pull request #33 from joshuadanpeterson/codex/update-doc/typewriter.txt-with-twpreservecolumn-command
- docs(help): add TWPreserveColumn command
- docs: update CHANGELOG.md for v0.6.14 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.16...v0.6.15)

## [v0.6.14](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.14) (2025-06-04)
- Merge pull request #32 from joshuadanpeterson/codex/add-tests-for-typewriter-state-toggle
- test(utils): add state toggle spec
- docs: update CHANGELOG.md for v0.6.13 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.15...v0.6.14)

## [v0.6.13](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.13) (2025-06-03)
- Merge pull request #31 from joshuadanpeterson/codex/find-and-fix-important-bug
- fix: validate LSP position recursively
- docs: update CHANGELOG.md for v0.6.12 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.14...v0.6.13)

## [v0.6.12](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.12) (2024-12-28)
- Merge pull request #26 from sabinmarcu/main
- fix(autocommands): Add missing utils import
- docs: update CHANGELOG.md for v0.6.11 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.13...v0.6.12)

## [v0.6.11](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.11) (2024-10-20)
- Merge pull request #25 from joshuadanpeterson/fix/restore-column-retention-issue-16
- fix(autocommands): Restore default column retention behavior (Issue #16)
- docs: update CHANGELOG.md for v0.6.10 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.12...v0.6.11)

## [v0.6.10](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.10) (2024-10-19)
- Merge pull request #24 from joshuadanpeterson/twdisable-autocmd-column-preservation
- fix(autocommands): Fix issue with column preservation in TWDisable command
- docs: update CHANGELOG.md for v0.6.9 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.11...v0.6.10)

## [v0.6.9](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.9) (2024-10-19)
- Merge pull request #23 from joshuadanpeterson/21-searching-doesnt-move-cursor-to-the-correct-place

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.10...v0.6.9)

## [v0.6.6](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.6) (2024-07-29)
- Merge pull request #17 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.6.5 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.9...v0.6.6)

## [v0.6.5](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.5) (2024-07-29)
- feat(autocommands): Preserve column position when moving between lines of different lengths
- docs: update CHANGELOG.md for v0.6.4 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.6...v0.6.5)

## [v0.6.4](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.4) (2024-07-21)
- docs: update CHANGELOG.md for v0.6.3 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.5...v0.6.4)

## [v0.6.3](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.3) (2024-07-21)
- Merge pull request #15 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.6.2 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.4...v0.6.3)

## [v0.6.2](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.2) (2024-07-21)
- Merge branch 'main' into dev
- docs: update CHANGELOG.md for v0.6.1 and remove duplicate entries
- docs: update CHANGELOG.md for v0.5.1 and remove duplicate entries
- Merge pull request #14 from joshuadanpeterson/dev

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.3...v0.6.2)

## [v0.6.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.1) (2024-07-21)
- Merge branch 'dev' of https://github.com/joshuadanpeterson/typewriter.nvim into dev
- feat(README): Add supported filetypes/languages section to README
- docs: update CHANGELOG.md for v0.6.0 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.2...v0.6.1)

## [v0.6.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.6.0) (2024-07-21)
- feat: Add throw_statement to Java significant blocks
- feat: Add OCaml significant node types to M.expand table for centering
- feat: Add significant node types for Zig filetype for centering
- feat: Add significant node types for C language
- feat: Add significant node types for C# in center_block_config
- feat: Add significant C++ node types to center_block_config
- feat: Add significant Swift node types to center block config
- feat: Add Dart node types to center block config
- docs(help): Update help docs
- feat: Add significant JSON node types to center_block_config
- feat: Add significant CSS node types to center_block_config.lua
- feat: Add YAML significant node types to center block config
- feat: Add significant Lua node types for centering
- feat: Add significant Rust node types for centering
- feat: Add significant Go node types for centering
- feat(gitignore): Add test files to gitignore
- feat: Add significant Python node types for centering
- feat: Add significant JavaScript node types for centering
- Merge branch 'dev' of https://github.com/joshuadanpeterson/typewriter.nvim into dev
- feat: Add significant Bash node types for centering
- docs: update CHANGELOG.md for v0.5.0 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.1...v0.6.0)

## [v0.5.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.5.1) (2024-07-20)
- Merge pull request #14 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.5.0 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.6.0...v0.5.1)

## [v0.5.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.5.0) (2024-07-20)
- Merge branch 'dev' of https://github.com/joshuadanpeterson/typewriter.nvim into dev
- feat: Update significant node types for centering
- refactor(test): Remove test.txt
- docs: update CHANGELOG.md for v0.4.26 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.5.1...v0.5.0)

## [v0.4.26](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.26) (2024-07-19)
- refactor(CHANGELOG): Update CHANGELOG
- docs: update CHANGELOG.md for v0.4.25 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.5.0...v0.4.26)

## [v0.4.25](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.25) (2024-07-19)

- feat(workflow): Integrate CHANGELOG generation into release action
- chore(update_changelog): Remove update_changelog.sh
- fix: Fix Update CHANGELOG script
- docs(test): Add test file
- Merge branch 'dev' of https://github.com/joshuadanpeterson/typewriter.nvim into dev
- docs: update CHANGELOG.md for v0.4.24 and remove duplicate entries
- refactor(commands): Remove 'stop traversal' statement
- style(commands): Remove debug print statements
- feat(center_block_config): Add new node
- refactor(center_block_and_cursor): Add new nodes
- feat(center_block_config): Add 'declaration_list' to node list
- fix: Improve get_expand_root logic for better PHP block handling
- fix: Improve center_block_and_cursor function for better PHP block handling
- feat(commands): Correctly center code block even when near bottom of the file
- Merge branch 'main' into dev
- docs: update CHANGELOG.md for v0.4.23 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.26...v0.4.25)

## [v0.4.24](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.24) (2024-07-19)

- style(commands): Remove debug print statements
- feat(center_block_config): Add new node
- refactor(center_block_and_cursor): Add new nodes
- feat(center_block_config): Add declaration_list to node list
- fix: Improve get_expand_root logic for better PHP block handling
- fix: Improve center_block_and_cursor function for better PHP block handling
- feat(commands): Correctly center code block even when near bottom of the file

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.25...v0.4.24)

## [v0.4.23](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.23) (2024-07-19)

- Merge pull request #11 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.4.22 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.24...v0.4.23)

## [v0.4.22](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.22) (2024-07-19)

- fix(commands): Move helper functions outside specific functions to avoid nil error
- docs: update CHANGELOG.md for v0.4.21 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.23...v0.4.22)

## [v0.4.21](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.21) (2024-07-18)

- Merge pull request #10 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.4.20 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.22...v0.4.21)

## [v0.4.20](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.20) (2024-07-18)

- Merge branch dev of https://github.com/joshuadanpeterson/typewriter.nvim into dev
- feat(docs): Update CHANGELOG and TODO in help docs
- docs: update CHANGELOG.md for v0.4.19 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.21...v0.4.20)

## [v0.4.19](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.19) (2024-07-18)

- feat(docs): Add top-level tag to typewriter help file
- docs: update CHANGELOG.md for v0.4.18 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.20...v0.4.19)

## [v0.4.18](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.18) (2024-07-07)

- Merge pull request #6 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.4.17 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.19...v0.4.18)

## [v0.4.17](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.17) (2024-07-07)

- Merge branch main into dev
- docs: update CHANGELOG.md for v0.4.16 and remove duplicate entries
- Merge branch dev of https://github.com/joshuadanpeterson/typewriter.nvim into dev Update local repo with remote changes
- refactor(ci): improve CHANGELOG.md generation to prevent duplicate entries
- Update CHANGELOG.md
- refactor(ci): improve release workflow to handle existing releases
- Merge branch dev of https://github.com/joshuadanpeterson/typewriter.nvim into dev Update local remote with remote changes
- docs(README): add new features and link to wiki articles
- feat(core): add state tracking and update documentation

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.18...v0.4.17)

## [v0.4.16](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.16) (2024-07-07)

- Merge branch dev of https://github.com/joshuadanpeterson/typewriter.nvim into dev Update local repo with remote changes
- refactor(ci): improve CHANGELOG.md generation to prevent duplicate entries
- docs: update CHANGELOG.md for v0.4.16 and remove duplicate entries
- Update CHANGELOG.md
- refactor(ci): improve release workflow to handle existing releases
- Merge branch dev of https://github.com/joshuadanpeterson/typewriter.nvim into dev Update local remote with remote changes
- docs(README): add new features and link to wiki articles
- feat(core): add state tracking and update documentation
- Merge pull request #5 from joshuadanpeterson/dev
- docs: update CHANGELOG.md for v0.4.15 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.17...v0.4.16)

## [v0.4.15](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.15) (2024-07-06)

- chore(ci): Update push branches
- docs(help): improve and expand plugin documentation
- refactor(init): lazy-load dependencies and simplify setup
- docs: enhance plugin documentation and comments
- Merge branch main of https://github.com/joshuadanpeterson/typewriter.nvim Bring local repo into congruency with remote repo
- docs(help): generate initial plugin documentation
- docs: update CHANGELOG.md for v0.4.14 and remove duplicate entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.16...v0.4.15)

## [v0.4.14](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.14) (2024-07-05)

- Merge branch main of https://github.com/joshuadanpeterson/typewriter.nvim Update local repo with remote changes
- fix(ci): resolve duplicate entries in CHANGELOG generation
- docs: update CHANGELOG.md for v0.4.13 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.15...v0.4.14)

## [v0.4.13](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.13) (2024-07-05)

- refactor(ci): Enhance CHANGELOG management to remove duplicate entries
- docs: update CHANGELOG.md for v0.4.12 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.14...v0.4.13)

## [v0.4.12](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.12) (2024-07-05)

- Update CHANGELOG.md
- docs: update CHANGELOG.md for v0.4.11 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.13...v0.4.12)

## [v0.4.11](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.11) (2024-07-05)

- Merge pull request #4 from joshuadanpeterson/center-horizontally
- docs: update CHANGELOG.md for v0.4.10 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.12...v0.4.11)

## [v0.4.10](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.10) (2024-07-05)

- Update CHANGELOG.md
- docs: update CHANGELOG.md for v0.4.9 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.11...v0.4.10)

## [v0.4.9](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.9) (2024-07-05)

- Update CHANGELOG.md
- docs: update CHANGELOG.md for v0.4.8 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.10...v0.4.9)

## [v0.4.8](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.8) (2024-07-05)

- refactor(ci): enhance CHANGELOG management with improved formatting and time handling
- docs: update CHANGELOG.md for v0.4.7 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.9...v0.4.8)

## [v0.4.7](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.7) (2024-07-05)

- Update CHANGELOG.md
- docs: update CHANGELOG.md for v0.4.6 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.8...v0.4.7)

## [v0.4.6](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.6) (2024-07-05)

- Merge branch center-horizontally of https://github.com/joshuadanpeterson/typewriter.nvim into center-horizontally Bringing local repo into line with remote repo
- refactor(ci): optimize CHANGELOG update process in release workflow
- docs: update CHANGELOG.md for v0.4.5 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.7...v0.4.6)

## [v0.4.5](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.5) (2024-07-05)

- Update CHANGELOG.md
- docs: update CHANGELOG.md for v0.4.4 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.6...v0.4.5)

## [v0.4.4](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.4) (2024-07-05)

- Update CHANGELOG.md
- docs: update CHANGELOG.md for v0.4.3 and standardize all entries

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.5...v0.4.4)

## [v0.4.3](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.3) (2024-07-05)

- Merge branch center-horizontally of https://github.com/joshuadanpeterson/typewriter.nvim into center-horizontally Update local branch with remote CHANGELOG generation
- feat(ci): standardize all CHANGELOG entries with dates and changelog links
- docs: update CHANGELOG.md for v0.4.2

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.4...v0.4.3)

## [v0.4.2](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.2) (2024-07-05)

- fix(ci): resolve sed error in CHANGELOG update step
- fix(ci): resolve syntax error in CHANGELOG update step
- feat(ci): implement automated CHANGELOG.md updates in release workflow

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.3...v0.4.2)

## [v0.4.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.1) (2024-07-05)

## [Unreleased](https://github.com/joshuadanpeterson/typewriter.nvim/tree/HEAD)
**Fixed bugs:**
- Fix `$` Command Issue in Normal Mode [\#2](https://github.com/joshuadanpeterson/typewriter.nvim/pull/2) ([joshuadanpeterson](https://github.com/joshuadanpeterson))

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.2...v0.4.1)

## [v0.4.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.4.0) (2024-07-05)

**Fixed bugs:**
- In normal mode with plugin installed using command $ - end of line not reached. [\#1](https://github.com/joshuadanpeterson/typewriter.nvim/issues/1)

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.1...v0.4.0)

## [v0.3.2](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.3.2) (2024-07-04)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.4.0...v0.3.2)

## [v0.3.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.3.0) (2024-07-01)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.3.2...v0.3.0)

## [v0.3.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.3.1) (2024-07-01)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.3.0...v0.3.1)

## [v0.2.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.2.0) (2024-06-30)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.3.1...v0.2.0)

## [v0.1.5](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.1.5) (2024-06-16)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.2.0...v0.1.5)

## [v0.1.4](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.1.4) (2024-06-16)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.1.5...v0.1.4)

## [v0.1.3](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.1.3) (2024-06-16)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.1.4...v0.1.3)

## [v0.1.2](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.1.2) (2024-06-16)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.1.3...v0.1.2)

## [v0.1.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.1.1) (2024-06-16)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.1.2...v0.1.1)

## [v0.1.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.1.0) (2024-06-16)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.1.1...v0.1.0)

## [v0.0.9](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.9) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.1.0...v0.0.9)

## [v0.0.8](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.8) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.9...v0.0.8)

## [v0.0.7](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.7) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.8...v0.0.7)

## [v0.0.4](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.4) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.7...v0.0.4)

## [v0.0.5](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.5) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.4...v0.0.5)

## [v0.0.6](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.6) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.5...v0.0.6)

## [v0.0.3](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.3) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.6...v0.0.3)

## [v0.0.2](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.2) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.3...v0.0.2)

## [v0.0.1](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v0.0.1) (2024-06-15)


[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.2...v0.0.1)

## [v1.0.0](https://github.com/joshuadanpeterson/typewriter.nvim/tree/v1.0.0) (2024-06-15)

\* _This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)_

[Full Changelog](https://github.com/joshuadanpeterson/typewriter.nvim/compare/v0.0.1...v1.0.0)

