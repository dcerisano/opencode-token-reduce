# Conventions

## AGENTS.md Rules (apply to all agent behavior)

- **Startup**: mandatory `serena_initial_instructions` + `context7_query-docs /websites/context7 initialization` on first message.
- **No-echo**: never repeat/paraphrase/summarize tool output.
- **Efficiency**: `ls -a` over `ls`. Read only needed content; prefer offset/limit. If stuck 3+ attempts, stop and summarize.
- **Tone**: no first person, no emoji, no casual language. State what was done, not who did it.
- **Before changes**: >1 file edit requires upfront 1-3 sentence summary. Never edit generated files. No git status/diff/log before committing.
- **Git**: `git add -A && git commit && git push` in one sequence without intermediate inspection.

## opencode.json Conventions

- MCP servers defined under `mcp` key with `enabled: true`.
- Agent build config uses `temperature: 0, top_p: 1`.
- Command templates defined under `command` key.
- `instructions` array references `AGENTS.md`.
- LSP enabled at top level.
