# AGENT RULES

## STARTUP (mandatory, every session)

1. `serena_initial_instructions`
2. `serena_activate_project`
3. Verify `CONTEXT7_API_KEY` is set; if missing, prompt. Context7 is primary docs source (replaces `webfetch`).
4. Read `README.md` via `serena_read_file`.
5. All rules below apply for all subsequent operations.

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

## COMMIT & PUSH

1. Stage all intended files, then ask user: "commit & push?"
2. Don't commit before asking.
3. If approved, commit then push.
4. Before push: change → verify (build/test/lint) → commit → push.
5. Fetch first: `git fetch origin && git log --oneline HEAD..origin/HEAD`.
6. If git-crypt: merge with `-X theirs`, never rebase.

## CONTEXT7 — PRIMARY DOCS SOURCE

Context7 MCP must be used **before** `webfetch` for any library/framework/SDK/API/CLI/cloud query. Use even when you think you know the answer.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

**Lookup flow:**
1. Start with `resolve-library-id` (unless user provides exact `/org/project` ID).
2. Pick best match by: name match, description relevance, snippet count, source reputation (High/Medium), benchmark score.
3. `query-docs` with selected library ID and the user's full question.
4. Answer with fetched docs; include examples and cite version.
5. Only if Context7 returns nothing relevant — fall back to `webfetch`.
