# Tech Stack

- **OpenCode** — model selection, MCP orchestration, agent definitions, skills, commands
- **Serena** — via `uvx` from `git+https://github.com/oraios/serena` (Python 3.13), started as MCP server
- **Context7** — remote MCP server at `https://mcp.context7.com/mcp`, requires `CONTEXT7_API_KEY` env var
- **OpenCode DCP** — `@tarquinen/opencode-dcp` plugin for automatic context pruning and compression
- **OpenCode plugin** — `@opencode-ai/plugin` v1.17.11 for built-in capabilities
- Languages: none configured in Serena (`languages: []`), OpenCode LSP enabled
