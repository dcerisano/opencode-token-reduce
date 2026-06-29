# Conventions

## Config files
- `opencode.json` follows [OpenCode config schema](https://opencode.ai/config.json)
- Commands in `.opencode/commands/` use Markdown + YAML frontmatter (`description`, `agent` fields)
- Skills in `.opencode/skills/` use Markdown + YAML frontmatter (`name`, `description` fields)

## Memory files (`.serena/memories/`)
- Follow conventions in `mem:memory_maintenance`
- Dense agent notes, terse bullets, no prose
- References to other memories use `mem:` prefix in backticks
- Auto-staged on push via `.githooks/pre-push`

## Git
- Template repo: `dcerisano/opencode-token-reduce`
- Pre-push hook auto-stages `.serena/memories/*.md`

## Permissions (opencode.json)
- `edit`: deny (Serena handles editing)
- `write`: deny (Serena handles file writes)
- `bash`: allow all except `git commit*` and `git push*` which require ask

## Agent settings
- Build agent: temperature=0.2, top_p=0.8