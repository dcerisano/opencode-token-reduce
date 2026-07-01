# opencode-token-reduce

Drop-in OpenCode configuration template that reduces AI token usage by pairing Serena (semantic code analysis) with Context7 (live docs) under strict efficiency rules.

## Structure

- `opencode.json` — main config: plugins, MCP servers (Serena + Context7), agent build settings, permissions, LSP
- `.opencode/dcp.jsonc` — project-level DCP (Dynamic Context Pruning) config for automatic token reduction
- `.opencode/commands/migrate.md` — `/migrate` command to merge template into an existing project
- `.opencode/skills/memory-management/SKILL.md` — memory maintenance workflow skill
- `.serena/` — Serena project config (`project.yml`, `.gitignore`) and `memories/` storage

## Key invariants

- **No business code** — this is a config-only template. All `.opencode/` and `.serena/` files are structural configs.
- **Model-agnostic** — works with any LLM backend OpenCode supports. DCP limits use `"X%"` to auto-scale.
- **Compaction** configured with `reserved: 50000` (5% of 1M window) for proper headroom.
- **DCP compress** listed as a primary tool for higher model priority.
- **Permissions** — edit/write allowed, bash allowed except git commit/push (ask-first). See `opencode.json`.
- **MCP servers** — Serena (local, via `uvx`), Context7 (remote).
- Language servers are **not configured** (`languages: []` in `project.yml`) — LSP is still enabled at OpenCode level.
- Serena dashboard auto-launch disabled to avoid tray/browser windows.
- Uses `.opencode/` and `.serena/` gitignore patterns to exclude `node_modules/`, `package*.json`, `bun.lock`, and `/cache`.

- **No business code** — this is a config-only template. All `.opencode/` and `.serena/` files are structural configs.
- **Model-agnostic** — works with any LLM backend OpenCode supports.
- **Permissions** — edit/write allowed, bash allowed except git commit/push (ask-first). See `opencode.json`.
- **MCP servers** — Serena (local, via `uvx`), Context7 (remote).
- Language servers are **not configured** (`languages: []` in `project.yml`) — LSP is still enabled at OpenCode level.
- Serena dashboard auto-launch disabled to avoid tray/browser windows.
- Uses `.opencode/` and `.serena/` gitignore patterns to exclude `node_modules/`, `package*.json`, `bun.lock`, and `/cache`.

## Related memories

- `mem:dcp_config` — DCP plugin configuration rationale (limits, nudge force, protected tools)
- `mem:tech_stack` — tooling dependencies
- `mem:suggested_commands` — common commands
- `mem:conventions` — code/style conventions
- `mem:task_completion` — verification steps

- `mem:tech_stack` — tooling dependencies
- `mem:suggested_commands` — common commands
- `mem:conventions` — code/style conventions
- `mem:task_completion` — verification steps
