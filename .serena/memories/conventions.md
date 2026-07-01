# Conventions

- **AGENTS.md** — concise directives for agent behavior: be brief, use Serena for code analysis, Context7 for docs, no emojis unless asked
- **Memory format** — dense agent notes, terse bullets. Avoid prose, rationale, examples unless preventing likely mistakes
- **Config format** — opencode.json is the single source of truth for MCP servers, permissions, agents, skills
- **Permissions** — `edit: allow`, `write: allow`, `bash: allow` (except git commit/push = ask)
- **No code** — this is a config-only template; don't write application code
- **Skills** — loaded from `.opencode/skills/` with `skill` tool; memory management is the primary skill
