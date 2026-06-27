# Tech Stack

- **OpenCode** — model selection, MCP server orchestration, agent definitions, skill loading, command templates (v1.17.11 plugin via `.opencode/node_modules/`)
- **Serena** — semantic code tools (symbol search, targeted body replacement, diagnostics, batch reads, safe rename). Runs via `uvx -p 3.13 --from git+https://github.com/oraios/serena serena start-mcp-server`
- **Context7** — live library docs via MCP remote at `https://mcp.context7.com/mcp`. API key from `CONTEXT7_API_KEY` env var.
- **uvx** — Python tool runner (Serena dependency). Installed via `curl -LsSf https://astral.sh/uv/install.sh | sh`.
- **LSP** — enabled in `opencode.json` for language-aware symbol resolution.
- **Node.js** — OpenCode plugin dependency in `.opencode/package.json`.
