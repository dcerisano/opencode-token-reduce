# opencode-token-reduce — Tech Stack

## Languages (configured in .serena/project.yml)
- Python (auto-installed LSP: pyright)
- TypeScript (auto-installed LSP: typescript-language-server; also covers JS)
- Java (auto-installed LSP: eclipse-jdtls)
- C/C++ (auto-installed LSP: clangd)
- Bash (auto-installed LSP: bash-language-server)
- JSON (auto-installed LSP: json-language-server)

## Tooling
- **OpenCode** — model selection, MCP server orchestration, agent definitions, skill loading, command templates
- **Serena** — semantic code analysis/editing (symbol search, targeted replacements, diagnostics, rename)
- **Context7** — live documentation/API lookups (library ID resolution, versioned code examples)
- **uvx** — runs Serena MCP server (Python 3.13)
- **Git** — version control (GitHub template)

## Dependencies
- `.opencode/package.json`: `@opencode-ai/plugin@1.17.11`
- Env vars: `CONTEXT7_API_KEY` (required for Context7 MCP server)

## Serena backend
- LSP-based (not JetBrains)
- UTF-8 encoding
- LF line endings
- Respects .gitignore
