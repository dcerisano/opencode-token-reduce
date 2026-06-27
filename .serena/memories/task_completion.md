# Task Completion Verification

This project has no application source code and no traditional test/lint/format/type-check tooling. It is an OpenCode configuration template.

## Verification

1. **Json syntax** — `python3 -c "import json; json.load(open('opencode.json'))"` to validate `opencode.json`.
2. **Memory references** — run `serena memories check` from project root to verify cross-memory references.
3. **File integrity** — `ls -a` confirms expected files: `opencode.json`, `AGENTS.md`, `.gitignore`, `.opencode/`.

No other verification commands are applicable.
