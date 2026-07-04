# Tech Stack

- **OpenCode** (latest) — agent orchestration, MCP server management, skill loading, permissions. CLI entrypoint: `opencode`.
- **Serena** (git+https://github.com/oraios/serena) — code analysis MCP server started via `uvx`. Configured in `opencode.json` under `mcp.serena`. Provides semantic tools (find_symbol, replace_symbol_body, diagnostics, etc.) as primary code interaction.
- **Context7** (remote MCP at https://mcp.context7.com/mcp) — documentation lookup MCP. Requires `CONTEXT7_API_KEY` env var. Resolves library IDs and returns targeted API references.
- **DCP** (@tarquinen/opencode-dcp) — OpenCode plugin for dynamic context pruning (compression nudges, dedup, error pruning). Configured in `.opencode/dcp.jsonc`.
- **Language servers**: None configured (Serena project.yml has empty languages list — this is a config-only project with no application source code).
- **Runtime dependencies**: Python 3.13 (for Serena via uvx), Node.js/npm (for DCP plugin), GitHub CLI (optional, for template usage).
