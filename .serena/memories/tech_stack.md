# Tech Stack

- **OpenCode v1** — model selection, MCP orchestration, agent definitions, skill loading, command templates. Config: `opencode.json`
- **Serena** — semantic code analysis/editing (symbol search, targeted body replacement, diagnostics, batch reads). Runs via `uvx -p 3.13 --from git+https://github.com/oraios/serena serena start-mcp-server --context=ide --project-from-cwd`
- **Context7** — live documentation lookup. Remote MCP at `https://mcp.context7.com/mcp`. Requires `CONTEXT7_API_KEY` env var.
- **@opencode-ai/plugin 1.17.11** — only npm dependency (in `.opencode/package.json`)
- **Auto-installed LSPs** (Serena downloads on first use):
  - Python → pyright
  - TypeScript/JS → typescript-language-server
  - Java → eclipse-jdtls
  - C/C++ → clangd
  - Bash → bash-language-server
  - JSON → json-language-server
- **Tools**: uv/uvx (Python), npm (Node), git
- **Languages configured** in `.serena/project.yml`: python, typescript, java, cpp, bash, json

## File Layout

```
opencode-token-reduce/
├── opencode.json              # MCP servers, agent config, permissions, LSP toggle
├── AGENTS.md                  # Agent rules, startup, tone, conventions
├── .gitignore
├── .opencode/
│   ├── .gitignore
│   ├── package.json           # @opencode-ai/plugin (gitignored)
│   ├── skills/
│   │   └── memory-management/ # Memory sync skill
├── .serena/
│   ├── project.yml            # Languages, encoding, ignored paths, modes
│   ├── memories/              # Markdown memories (created by serena_write_memory)
│   ├── cache/                 # LSP/index cache (gitignored)
│   └── project.local.yml      # Local overrides (gitignored)
```
