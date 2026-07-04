# Task Completion

After completing a coding task (file edits, config changes, etc.):

1. **No lint/format/typecheck step exists** — this is a config-only template project with no application code and no CI pipeline. There are no lint, format, or typecheck commands defined. Do not attempt to run them.
2. **Verify** — for config JSON changes, ensure valid JSON syntax. For markdown changes, no verification step needed.
3. **Commit** — only when explicitly asked by the user. Use conventional commit style matching project scope (e.g., "feat:", "fix:", "chore:").
4. **Memory update** — use `mem:memory-management` skill (`skill tool with name "memory-management"`) after meaningful changes.
