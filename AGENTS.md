# AGENT RULES

## STARTUP (mandatory, every session)

**Strict sequencing — do exactly these steps in order. No other tool calls. No text output until startup is complete.**

1. `list_mcp_resources` for both MCP servers. If either fails or times out, set a warning to emit after startup.
2. `serena_initial_instructions`
3. `serena_activate_project`
4. `context7_query-docs` with library ID `/anomalyco/opencode` and query `configuration`
5. **STOP. Do not make any further tool calls. Do not read skills. Do not read files. Do not ask questions. Do not output text. Wait for the user's next instruction.**
6. All rules below apply for all subsequent operations.

## NO-ECHO RULE (overrides all)

Use tools before answering. Never guess. Never claim file access is missing. Tool results beat primed context.
**Never repeat, paraphrase, or summarize tool output.** If a tool already communicated it, stay silent.

Per-response decision: tool just output? → no echo. Nothing to add? → say nothing.

## SERENA FIRST

Serena tools are mandatory for code analysis/reading/editing. Native tools (read/write/edit/grep/glob) are fallbacks only.
- `serena_search_for_pattern` → grep, `serena_find_file` → glob, `serena_get_symbols_overview`/`serena_find_symbol` → read, `serena_read_file` → read, `serena_replace_content` → edit
- Call `serena_get_diagnostics_for_file` before suggesting fixes.
- Batch reads: read multiple files in one call, not one at a time.

## EFFICIENCY

- `ls -a` over `ls`. Read only what's needed; prefer offset/limit.
- If stuck 3+ attempts on same error, stop and summarize.

## TONE

No first person. No emoji. No casual language. State what was done, not who did it.

## BEFORE CHANGES

- Editing >1 file? State approach in 1-3 sentences first.
- Never edit generated files. Check for "auto-generated".
- Check .gitignore before staging. Run git status before commit.
## CONTEXT7 — PRIMARY DOCS SOURCE

Context7 MCP must be used **before** `webfetch` for any library/framework/SDK/API/CLI/cloud query. Use even when you think you know the answer.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.
