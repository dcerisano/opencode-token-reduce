# Tech Stack

## Languages
None registered (Serena project.yml `languages: []`)

## Runtimes
- Python 3.13 (for Serena — launched via uvx)
- OpenCode CLI

## Package Managers
- npm — for `.opencode/` plugin deps (`@opencode-ai/plugin@1.17.12`)
- uv — for Serena (via `uvx -p 3.13`)

## Key Dependencies
- `@opencode-ai/plugin` — declared in `.opencode/package.json`
- `@tarquinen/opencode-dcp` — OpenCode plugin (installed globally)
- Serena MCP — from `git+https://github.com/oraios/serena` (via uvx)

## No Build / No Test
No build step, no test framework, no linter, no formatter, no type checker.
