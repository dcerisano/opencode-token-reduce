# Suggested Commands

## Startup
- `opencode --prompt "startup"` — quick-start alias (oc) that loads this project in OpenCode

## Template Usage
- `gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone` — create new project from template
- `opencode --prompt "/migrate /path/to/target"` — migrate config into existing project

## Serena
- `serena memories check` — validate memory references from project root
- Serena dashboard: http://127.0.0.1:24282/dashboard/index.html (auto-launch disabled)

## Diagnostics
- `opencode` — main CLI; run from project root to start a session with this config loaded

## Node/npm (DCP dependency)
- `npm install` (in `.opencode/`) if DCP dependencies need updating

## Git
- Standard git commands; note `git push` requires `ask` permission in opencode.json
