# opencode-token-reduce — Conventions

## Code/style
- Never edit generated files; check for "auto-generated" header.
- Never add comments to code unless asked.
- Prefer editing existing files over creating new ones.
- Do not create documentation files (*.md) or README unless explicitly requested.

## Tone
- No first person, no emoji, no casual language.
- State what was done, not who did it.
- Use GitHub-flavored markdown; output renders in monospace on CLI.

## Efficiency
- Use `ls -a` over `ls`.
- Read only what's needed; use offset/limit for large files.
- If stuck 3+ attempts on same error, stop and summarize.
- Use Serena semantic tools over native read/write/grep/glob when possible.
- Use Context7 for library/framework/SDK/API docs instead of stale training data.

## Git
- Never run git status/diff/log before committing (wasted tokens).
- On push: stage all (`git add -A`), commit, push in one sequence.
- Only commit when explicitly asked.
- Do not update git config, skip hooks, force-push, or create empty commits unless asked.

## Editing workflow
- Editing >1 file? State approach in 1-3 sentences first.
- Prefer Serena symbolic editing tools: `replace_symbol_body`, `insert_after_symbol`, `insert_before_symbol`, `rename_symbol`.
- For within-symbol edits, use `replace_content` with regex mode (wildcards preferred over full text).
- Use `find_referencing_symbols` to discover and update references when changing symbols.

## Serena tool usage
- `get_symbols_overview` + `find_symbol` over reading entire files.
- Line numbers from Serena tools are 0-based.
