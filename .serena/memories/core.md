# opencode-token-reduce — Core

A drop-in OpenCode configuration template that reduces AI token usage by pairing Serena (efficient code analysis), Context7 (live documentation lookup) and DCP (dynamic context pruning).

## Structure

- `opencode.json` — main OpenCode config: MCP servers (serena, context7), agents, permissions, DCP plugin
- `AGENTS.md` — session instructions: prefer serena over grep/glob, context7 over webfetch, bootstrap on start
- `.opencode/skills/` — bootstrap, memory-management
- `.opencode/commands/` — migrate command
- `.opencode/dcp.jsonc` — DCP plugin configuration
- `.serena/` — serena project config (languages: none), memories, cache
- `README.md` — usage docs, installation, token reduction table

## Invariants

- No application code — pure configuration template. Source of truth is config under `.opencode/` and root `opencode.json`.
- All configuration is project-scoped. Global `~/.config/opencode/` is never touched.
- On session start, `AGENTS.md` instructs bootstrap (report "Opencode Token Reduce BOOTSTRAP", load bootstrap skill).
- `grep` is denied in permissions — use `serena_search_for_pattern` instead.
- Serena memories are written via subagent (`subagent_type="general"`).
- `compress` is the primary context management tool (listed in `experimental.primary_tools`).
- Context7 requires `CONTEXT7_API_KEY` env var.

## Key Design

The project is model-agnostic. It prevents token bloat proactively (Serena + Context7 targeting semantic operations instead of full file reads) and reactively (DCP pruning accumulated bloat). See `mem:tech_stack` for tools and `mem:suggested_commands` for usage.
