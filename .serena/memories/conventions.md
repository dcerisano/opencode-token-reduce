# Conventions

## Agent behavior (from `AGENTS.md`)
- **NO-ECHO rule**: never repeat/paraphrase/summarize tool output. If a tool already communicated it, stay silent. After edits, state only the changed file path.
- **SUBAGENT rule**: every tool call MUST be delegated to a `task` subagent (type `general`). Subagent returns raw result as-is.
- **STARTUP sequence**: on every first user message, call `serena_initial_instructions` + `context7_query-docs` for `/websites/context7` with query `initialization`. Then check memories; if none, load `memory-management` skill and delegate creation to subagent.
- **EFFICIENCY**: prefer `ls -a`, read only what's needed. If stuck 3+ attempts on same error, stop and summarize.
- **TONE**: no first person, no emoji, no casual language. State what was done, not who did it.

## Code modification
- Native `edit`/`write` tools denied in `opencode.json`. Always use Serena's: `serena_replace_symbol_body`, `serena_replace_content`, `serena_insert_after_symbol`, `serena_insert_before_symbol`.
- Before editing >1 file, state approach in 1-3 sentences first.
- Never edit auto-generated files.

## Docs lookup
- Use `context7` tools for library/framework/SDK/API docs. Never rely on stale training data.

## Memory management
- Follow `mem:memory_management` skill guidelines: dense agent notes, not prose. `mem:core` is the graph root. Cross-reference with `` `mem:other_memory` `` syntax.
