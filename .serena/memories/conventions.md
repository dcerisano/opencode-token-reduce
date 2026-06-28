# Conventions

## Code Style
- **Tone**: No first person, no emoji, no casual language. State what was done, not who did it.
- **Brevity**: Prefer <4 lines of text per response. Answer directly without preamble/postamble.
- **No-echo rule**: Never repeat, paraphrase, or summarize tool output in text.
- **No comments**: Do NOT add any comments to code unless asked.

## Naming
- Memory names: lowercase, underscore_case, grouped by topic (e.g., `core`, `tech_stack`, `suggested_commands`)
- Memory references: backticks with `mem:` prefix (e.g., `` `mem:core` ``)

## Editing Rules
- **Never use native `edit`/`write` tools** — they are denied in `opencode.json`. Use Serena tools exclusively:
  - `serena_replace_symbol_body` — replace entire symbol body
  - `serena_replace_content` — regex/string-based file replacement
  - `serena_insert_after_symbol` / `serena_insert_before_symbol` — insert code around symbols
- Editing >1 file? State approach in 1-3 sentences first.
- Never edit auto-generated files. Check for "auto-generated" markers.
- Follow existing code conventions (imports, typing, libraries, patterns) observed in adjacent files.

## Docs Lookup
- Use `context7_query-docs` (Context7 MCP) for library/framework/API docs. Do not rely on training data for recent changes.
- Prefer Context7 over web search for library docs.

## Miscellaneous
- `ls -a` over `ls`. Read only what's needed; prefer offset/limit for file reads.
- If stuck 3+ attempts on same error, stop and summarize.
- Only commit when explicitly asked. Before commit, inspect `git status`, `git diff`, `git log --oneline -10`.
- Mandatory startup sequence (defined in `AGENTS.md`) must be executed on first message.
