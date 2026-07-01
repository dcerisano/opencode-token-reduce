# Tech Stack

- **OpenCode** — model selection, MCP orchestration, agent definitions, skills, commands
- **Serena** — proactive: prevents context bloat a priori via semantic code analysis. MCP server via `uvx` from `git+https://github.com/oraios/serena` (Python 3.13)
- **Context7** — proactive: prevents context bloat a priori via live docs lookup. Remote MCP server at `https://mcp.context7.com/mcp`, requires `CONTEXT7_API_KEY` env var
- **OpenCode DCP** — purely reactive: prunes conversation bloat after tokens have already been spent. `@tarquinen/opencode-dcp` plugin
- **OpenCode plugin** — `@opencode-ai/plugin` v1.17.11 for built-in capabilities
- Languages: none configured in Serena (`languages: []`), OpenCode LSP enabled
