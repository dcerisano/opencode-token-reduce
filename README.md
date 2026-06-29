# opencode-token-reduce

## ⚠️ WORK IN PROGRESS

Contributions, suggestions, and PRs are welcome!

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing) with **Context7** (live documentation lookup) under strict efficiency rules.

Use it as a GitHub template to bootstrap new projects with a pre-configured token-reducing environment. The template is model-agnostic — it works with any LLM backend that OpenCode supports.

## Token Savings

Serena and Context7 reduce token consumption across every phase of the SDLC by replacing expensive, full-file operations with targeted, semantic queries.

| SDLC Phase | Without | With Serena + Context7 | Est. Savings |
|---|---|---|---|
| **Code Comprehension** | Read entire files for relevant symbols | `get_symbols_overview` + `find_symbol` — symbol-level fetch | 60-80% |
| **Documentation Research** | Read full docs or use stale training data | `context7_query-docs` — versioned API snippets | 70-90% |
| **Code Editing** | Read full file, rewrite via regex/sed | `replace_symbol_body` / `insert_after_symbol` — symbol-level edit | 40-60% |
| **Search & Debugging** | grep/glob across codebase, read to understand | `find_referencing_symbols` / `find_implementations` — semantic refs | 50-70% |
| **Diagnostics** | grep logs, manual bisect | `get_diagnostics_for_file` — LSP diagnostics | 60-80% |
| **Library/Tool Setup** | Read setup guide, guess config | `context7_query-docs` — version-pinned lookups | 70-90% |
| **Refactoring** | Find all usages manually, edit each file | `rename_symbol` — single-call rename | 80-90% |

**Overall projection:** 50-70% fewer tokens consumed over the lifespan of a professional-grade project, with the largest gains in early phases (comprehension, research) and refactoring.

---

## Create a New Project from the Template

Create a new empty repository from this GitHub template with a single command:

```bash
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
git config core.hooksPath .githooks
```

This creates a new repository with the template's full configuration (agents, MCP servers, skills, efficiency rules) and no business code. The project starts clean — ready for OpenCode.

Start OpenCode with the startup prompt:

```bash
opencode --prompt "startup"
# or with the alias configured during installation:
oc
```

OpenCode launches Serena and Context7, and prompts for the first task with token-reducing defaults in place.

---

## Migrate into an Existing Project

To apply the token-reduce template to an existing project, use the `/migrate` command:

```bash
opencode --prompt "/migrate /path/to/your/project"
```

The command copies the template's config files (`opencode.json`, `.opencode/`, `.serena/`) into your project. **If any target file already exists, the command aborts immediately** and shows the full list of conflicting paths so you can resolve them manually. Remove or rename the conflicting files, then run `/migrate` again.

---

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
git config core.hooksPath .githooks
oc
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
git config core.hooksPath .githooks
oc
```

The Serena and Context7 MCP servers are configured in `opencode.json` and launch automatically on startup. The Serena web dashboard is available at [http://127.0.0.1:24282/dashboard/index.html](http://127.0.0.1:24282/dashboard/index.html) (auto-launch is disabled to avoid unnecessary tray/browser windows).

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
├── opencode.json                 # Main config: MCP servers, agents, LSP, permissions
├── .opencode/
│   ├── .gitignore                # Ignores node_modules/, package*.json, bun.lock
│   ├── commands/
│   │   └── migrate.md            # /migrate — merge template into existing project
│   └── skills/
│       └── memory-management/
│           └── SKILL.md
├── .serena/
│   ├── .gitignore                # Ignores /cache, /project.local.yml
│   └── memories/
│       └── .gitkeep              # Auto-stages .md memory files on push (via .githooks/)
├── .githooks/
│   └── pre-push                  # Auto-stages .serena/memories/*.md before push
└── README.md
```
