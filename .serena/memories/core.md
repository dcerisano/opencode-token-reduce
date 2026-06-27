# opencode-token-reduce — Core

Drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing Serena (efficient code analysis/editing) with Context7 (live documentation lookup) under strict efficiency rules. Used as a GitHub template to bootstrap new projects.

## Source map

```
opencode.json              # Main config: agent, MCP servers, LSP, commands
AGENTS.md                  # Startup, tool discipline, Context7 docs, tone, commit, memory updates
.opencode/
  package.json             # Opeencode plugin dependency (@opencode-ai/plugin 1.17.11)
  node_modules/
.serena/
  project.yml              # Serena project config (languages, encoding, ignored paths)
  memories/                # Serena memories (instructions for future agents)
```

## Key invariants

- AGENTS.md startup steps execute before any other action: `serena_initial_instructions` + `context7_query-docs` with `/websites/context7` and query `initialization`.
- `opencode.json` defines three custom commands: `test`, `fix`, `status`.
- Two MCP servers: Serena (local, via uvx) and Context7 (remote, via CONTEXT7_API_KEY env var).
- No-echo rule: tool output is never repeated, paraphrased, or summarized.
- No first person, emoji, or casual language in responses.
- After meaningful project changes, agents update relevant Serena memories and create new ones for uncovered domains (see AGENTS.md AFTER CHANGES — MEMORY UPDATES).

## References

- `mem:tech_stack` — language and tooling details
- `mem:suggested_commands` — available commands
- `mem:conventions` — code/style conventions
- `mem:task_completion` — verification commands
