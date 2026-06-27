# opencode-token-reduce — Tech Stack

## Languages
- Python (primary, for uvx/Serena)
- TypeScript (OpenCode plugin system)
- JSON/YAML (config files)

## Tooling
- OpenCode CLI — agent framework
- Serena (via uvx) — MCP server for code analysis & editing
- Context7 — MCP server for live documentation
- uvx — Python package runner (Serena bootstrap)

## Serena
- Languages: python, typescript, java, cpp, bash, json
- Encoding: utf-8
- No-onboarding mode enabled — agent creates memories via skill
- Project path: auto-detected via .serena/project.yml