# Task Completion Verification

## No Standard Checks
This is a config-only template. No tests, no build, no linter, no formatter, no type checker.

## Verification Steps
- `serena memories check` — verify memory integrity after creating/updating memories
- For config changes: validate manually by reviewing `opencode.json`, `dcp.jsonc`, etc.
- For migration: test `/migrate` against a throwaway git repo
- For OpenCode config: run `opencode --validate` if available
