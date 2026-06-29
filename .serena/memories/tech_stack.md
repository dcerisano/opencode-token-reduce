# Tech Stack

## OpenCode (runtime)
- Config: `opencode.json` (in root)
- Plugin: `@opencode-ai/plugin@1.17.11` (in `.opencode/package.json`)
- Two MCP servers configured:
  - **Serena** (local) — via `uvx` from `git+https://github.com/oraios/serena`, Python 3.13, `--context=ide`, web dashboard disabled
  - **Context7** (remote) — at `https://mcp.context7.com/mcp`, requires `CONTEXT7_API_KEY` env var

## Serena
- Auto-installed LSPs (no manual setup): python (pyright), typescript (typescript-language-server), java (eclipse-jdtls), cpp (clangd), bash (bash-language-server), json (json-language-server)
- Project config: `.serena/project.yml` — languages list, utf-8 encoding, `no-onboarding` mode, `ignore_all_files_in_gitignore: true`
- Cache dir: `.serena/cache/` (gitignored)
- Memories dir: `.serena/memories/` (tracked)

## No application dependencies
- This repo has no `package.json`, `requirements.txt`, or any build system at the root level.
- It is pure boilerplate/tooling — no runtime code to compile or install.
