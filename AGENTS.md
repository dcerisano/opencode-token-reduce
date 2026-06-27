# AGENT RULES

## STARTUP (mandatory, every session)

**Strict sequencing — do exactly these steps in order. No other tool calls. No text output until startup is complete.**

1. `serena_initial_instructions` and `serena_activate_project`
2. `context7_query-docs` with library ID `/websites/context7` and query `initialization`
3. **STOP. Do not make any further tool calls. Do not read skills. Do not read files. Do not ask questions. Do not output text. Wait for the user's next instruction.**
4. All rules below apply for all subsequent operations.

## NO-ECHO RULE (overrides all)

Use tools before answering. Never guess. Never claim file access is missing. Tool results beat primed context.
**Never repeat, paraphrase, or summarize tool output.** If a tool already communicated it, stay silent.

Per-response decision: tool just output? → no echo. Nothing to add? → say nothing.

## SERENA IS THE ONLY FILE ACCESS (ZERO EXCEPTIONS)

**Native tools (read/write/edit/grep/glob/bash-for-file-ops) are FORBIDDEN.** Serena is the only tool for all file operations. There are zero exceptions, zero fallbacks, zero circumstances where native tools may be used.

Serena tool mappings (mandatory, no alternatives):
- `serena_read_file` — reading files (NEVER use native `read`)
- `serena_search_for_pattern` — searching file contents (NEVER use native `grep`)
- `serena_find_file` — finding files by name (NEVER use native `glob`)
- `serena_get_symbols_overview` / `serena_find_symbol` — code symbol analysis (NEVER use native `read`)
- `serena_replace_content` — editing files (NEVER use native `edit`)
- `serena_create_text_file` — creating new files (NEVER use native `write`)
- `serena_get_diagnostics_for_file` — checking diagnostics before fixes
- `serena_insert_after_symbol` / `serena_insert_before_symbol` — adding code
- `serena_replace_symbol_body` — replacing function/class bodies

Even if Serena errors or seems slow, do not fall back to native tools. If Serena is genuinely unavailable, stop and report it.

## EFFICIENCY

- `ls -a` over `ls`. Read only what's needed; prefer offset/limit.
- If stuck 3+ attempts on same error, stop and summarize.

## TONE

No first person. No emoji. No casual language. State what was done, not who did it.

## BEFORE CHANGES

- Editing >1 file? State approach in 1-3 sentences first.
- Never edit generated files. Check for "auto-generated".
- Check .gitignore before staging. Run git status before commit.
## CONTEXT7 — EXCLUSIVE DOCS SOURCE

**NEVER use `webfetch` for library/framework/SDK/API/CLI/cloud documentation.** Context7 is the only allowed source.

Contact: Always call `context7_resolve-library-id` first to get the library ID, then `context7_query-docs`. Every single time. If Context7 has no docs on the topic, stop and report it — do not fall back to webfetch.

Reason: This repo exists to enforce Context7-first lookup. Violating this defeats the entire purpose.

Do not use Context7 for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.
