# Tech Stack

## Core
- **OpenCode** — AI coding agent orchestrator (model-agnostic)
- **Serena** — semantic code analysis/editing MCP server (Python 3.13 via `uvx`)
- **Context7** — live documentation MCP server (remote HTTP)

## Configuration format
- `opencode.json` — JSON with `$schema: https://opencode.ai/config.json`
- `.serena/project.yml` — YAML project configuration for Serena
- Commands/skills — Markdown with YAML frontmatter

## Package manager
- npm (Node.js) — minimal, only `@opencode-ai/plugin` dependency in `.opencode/package.json`
- `uvx` — Python package runner for Serena (no Python project files)

## Version pins
- `@opencode-ai/plugin`: 1.17.11
- Serena: installed from `git+https://github.com/oraios/serena` (no version pin)
- Python: 3.13

## Language servers
- None configured (`languages: []` in `.serena/project.yml`)
- LSP enabled at the OpenCode level (`"lsp": true` in `opencode.json`)