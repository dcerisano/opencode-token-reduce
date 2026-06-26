# tech_stack — opencode-token-reduce

## OpenCode Ecosystem
- **OpenCode** — editor/terminal app that loads the config (no version lock)
- **Model**: `deepseek-v4-flash-free` via `opencode` provider — configured with `temperature: 0`, `top_p: 1`, `reasoning_effort: low`, `thinking: enabled`
- **MCP servers**:
  - `serena` — local, via `uvx --from git+https://github.com/oraios/serena serena start-mcp-server`
  - `context7` — remote, `https://mcp.context7.com/mcp`, requires `CONTEXT7_API_KEY` env var
- **Skills paths**: `.opencode/skills` (loaded on demand via `skill` tool)

## Language Backend
- Serena project configured with empty `languages: []` — no language server started. This is expected (no app source to analyze; config files only).
- LSP backend (not JetBrains).

## External Dependencies
- `uvx` — required for Serena (install via `pip install uv` or `brew install uv`)
- `CONTEXT7_API_KEY` — required for Context7 MCP (free at context7.com)
- Optional: `ctx7` npm package for CLI-based doc lookup (`npm install -g ctx7@latest` / `npx ctx7@latest`)

## References
- Project layout: `mem:core`
