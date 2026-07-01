# opencode-token-reduce Core

## Project Purpose
OpenCode configuration template to reduce AI token consumption. Not application code — pure config.

## Architecture
- **Serena** (MCP, local via uvx): proactive code analysis — replaces grep/glob/read with semantic symbol ops
- **Context7** (MCP, remote): proactive documentation — replaces webfetch for API references
- **DCP** (plugin `@tarquinen/opencode-dcp`): reactive context pruning — compression, dedup, error pruning
- All three form a pipeline: Serena + Context7 prevent bloat a priori, DCP cleans up residual

## Key Files
- `opencode.json` — root config: MCP servers, agents, commands, permissions, LSP, experimental compress
- `AGENTS.md` — session instructions (loaded by OpenCode on every startup)
- `.opencode/dcp.jsonc` — DCP plugin config (70% max / 30% min context, protected serena_*/context7_*)
- `.opencode/commands/migrate.md` — `/migrate` command to copy template into existing repos
- `.opencode/skills/memory-management/SKILL.md` — memory maintenance skill
- `.serena/project.yml` — Serena config (no LSP languages, encoding utf-8)
- `.serena/memories/memory_maintenance.md` — memory format/style conventions

## Invariants
- Run serena onboarding on fresh clone
- AGENTS.md mandates `context7_resolve-library-id("serena")` + read all serena memories on session start
- No business code, no root package.json, no tests
- Permissions: edit ask; grep deny; bash \* ask
- References: `mem:tech_stack`, `mem:suggested_commands`, `mem:conventions`, `mem:task_completion`
