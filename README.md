# opencode-token-reduce

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing) with **Context7** (live documentation lookup) under strict efficiency rules.

Use it as a GitHub template to bootstrap new projects with a pre-configured token-reducing environment.

## Installation

### Linux

```bash
# GitHub CLI
sudo apt install gh          # Debian/Ubuntu

# OpenCode
curl -fsSL https://opencode.ai/install | bash

# uvx (Serena dependency)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Context7 API key (get one at https://context7.com)
export CONTEXT7_API_KEY="your_key_here"

# Quick startup alias
alias oc='opencode --prompt "startup"'

# Create a new project from this template
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
opencode
```

### Windows

```powershell
# GitHub CLI
winget install --id GitHub.cli

# OpenCode
winget install opencode

# uvx (Serena dependency)
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

# Context7 API key (get one at https://context7.com)
$env:CONTEXT7_API_KEY = "your_key_here"

# Quick startup alias
function oc { opencode --prompt "startup" }

# Create a new project from this template
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
opencode
```

The Serena and Context7 MCP servers are configured in `opencode.json` and launch automatically on startup.

---

## Tech Stack

### OpenCode

[OpenCode](https://opencode.ai) handles model selection, MCP server orchestration, agent definitions with granular permission scopes, skill loading, and command templates.

### Serena

[Serena](https://oraios.github.io/serena/) replaces native read/write/grep/glob with semantic operations — symbol search, targeted body replacement, diagnostics retrieval, and batch reads — reducing context per tool call.

### Context7

[Context7](https://context7.com) resolves library names to IDs and returns up-to-date API references and code examples, eliminating reliance on stale training data.

---

## Token Savings

Serena and Context7 reduce token consumption across every phase of the SDLC by replacing expensive, full-file operations with targeted, semantic queries.

| SDLC Phase | Without | With Serena + Context7 | Est. Savings |
|---|---|---|---|
| **Code Comprehension** | Read entire files to find relevant symbols | `get_symbols_overview` + `find_symbol` — fetch only symbol signatures and locations | 60-80% |
| **Documentation Research** | webfetch full docs pages or rely on stale training data | `context7_query-docs` returns concise, versioned API snippets | 70-90% |
| **Code Editing** | Read full file, then rewrite via regex/sed | `replace_symbol_body` / `insert_after_symbol` — edit at symbol level | 40-60% |
| **Search & Debugging** | grep/glob across codebase, read results to understand context | `find_referencing_symbols` / `find_implementations` — semantic cross-references | 50-70% |
| **Diagnostics** | grep logs, manual bisect | `get_diagnostics_for_file` — direct LSP diagnostic retrieval | 60-80% |
| **Library/Tool Setup** | Read entire setup guide, guess correct config | `context7_query-docs` with version-pinned library ID | 70-90% |
| **Refactoring** | Find all usages manually, edit each file | `rename_symbol` — single-call rename across codebase | 80-90% |

**Overall projection:** 50-70% fewer tokens consumed over the lifespan of a professional-grade project, with the largest gains in early phases (comprehension, research) and refactoring.

---

## File Layout

```
opencode-token-reduce/
├── opencode.json              # Main config: agent, MCP servers, LSP, commands
├── AGENTS.md                  # All rules: startup, tool discipline, Context7 docs, tone, commit
└── .gitignore
```
