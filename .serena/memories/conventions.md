# conventions — opencode-token-reduce

## General
- This is a configuration-only repo. No application source code conventions apply.
- AGENTS.md rules take precedence over everything: no tool-output echo, serena tools mandatory, no first-person, no preamble, batch reads preferred.
- All agents should load the mandatory-workflow skill at session start.

## File Conventions
- `opencode.json` — JSON with `$schema`, not JSONC (no comments).
- Skill files — YAML frontmatter (`---` delimited) + Markdown body. `name` and `description` in frontmatter are required.
- Agent files — YAML frontmatter with `description`, `mode: primary`, `permission` block, then body.
- Memory files — Markdown with `# title` heading, dense terse bullets, `mem:` backtick references.

## Design Patterns
- Two parallel doc-lookup paths exist (MCP tools and CLI). The MCP path is preferred; the CLI path is a fallback for when MCP is unavailable.
- Skills are loaded on demand via the `skill` tool. They are not baked into prompts.
- The `enforce` agent delegates to the mandatory-workflow skill at startup, then directs all subsequent behavior via AGENTS.md.
