# opencode-token-reduce

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing) with **Context7** (live documentation lookup) under strict efficiency rules.

Use it as a GitHub template to bootstrap new projects with a pre-configured token-reducing environment.

## Quick Start

```bash
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
opencode
```

Or click **"Use this template"** at `https://github.com/dcerisano/opencode-token-reduce`, then clone and run `opencode`.

---

## Prerequisites

### Linux

```bash
# GitHub CLI
sudo apt install gh          # Debian/Ubuntu

# OpenCode
curl -fsSL https://opencode.ai/install.sh | sh

# uvx (Serena dependency)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Context7 API key (get one at https://context7.com)
export CONTEXT7_API_KEY="your_key_here"

# Quick startup alias
alias oc='opencode --prompt "startup"'
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

## File Layout

```
opencode-token-reduce/
├── opencode.json              # Main config: model, MCP servers, agent, permissions, commands
├── AGENTS.md                  # All rules: startup, tool discipline, Context7 docs, tone, commit
├── .serena/
│   ├── project.yml            # Serena project configuration
│   └── memories/              # Persistent agent memories
└── .gitignore
```
