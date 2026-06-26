# suggested_commands — opencode-token-reduce

## OpenCode Commands (defined in opencode.json)
- `test` — "Run project tests and report pass/fail counts per tier. If any test fails, analyze the failure and fix it."
- `fix` — "Run the build/tests, identify any failures, fix them, then re-run until green. If a fix requires more than 3 attempts on the same error, stop and summarize the problem."
- `status` — "Show git branch, uncommitted changes, and recent commits."

## Context7 CLI (find-docs skill)
- `ctx7 library <name> <query>` — resolve a library name to a Context7 ID
- `ctx7 docs <libraryId> <query>` — fetch documentation for a resolved ID
- Pre-update: `npm install -g ctx7@latest` or `npx ctx7@latest <command>`

## Notes
- No project-level dev server, test runner, linter, formatter, or build system exists.
- `test` and `fix` commands are templates for downstream projects that copy this config; they have no effect in this repo itself.
- The only useful command in this repo is `git` operations and `opencode` itself.
