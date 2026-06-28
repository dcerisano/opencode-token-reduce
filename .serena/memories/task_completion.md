# Task Completion Verification

This is a **configuration-only template** — no application code, no language-specific test/lint/typecheck tooling.

## Verification Steps (general)

1. **LSP diagnostics**: Run `serena_get_diagnostics_for_file` on modified files and check for errors (severity 1-2).
2. **Symbol integrity**: Use `serena_find_referencing_symbols` to ensure renamed/deleted symbols don't leave dangling references.
3. **opencode.json validity**: Ensure JSON is valid (no trailing commas, correct schema).
4. **Markdown validity**: Ensure AGENTS.md, README.md, and memory files are valid markdown.
5. **Git status**: Run `git status` + `git diff` before any commit to verify only intended files changed.

## When Application Code Exists

If this template is used to bootstrap a project that later adds application code, the developer should:
- Define `build`, `test`, `lint`, `typecheck` scripts in `package.json`
- Update `opencode.json` with custom commands if applicable
- Update this memory with the actual verification commands
