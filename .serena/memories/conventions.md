# opencode-token-reduce — Conventions

## Code edits
- Use Serena tools (replace_symbol_body, replace_content, insert_after_symbol, insert_before_symbol) — never native edit/write
- Bash only for creating new files when Serena cannot create them
- Never edit generated files — check for "auto-generated" header

## Commits
- No git status/diff/log before committing — wasteful
- On push: git add -A, commit, push in one sequence
- No intermediate inspection

## Memory management
- Memories created on first session via STARTUP step 2
- Updated after meaningful project changes
- Committed to git on creation and after updates
- See mem:memory-maintenance for detailed rules