# opencode-token-reduce

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
```

This creates a new repository with the template's full configuration (agents, MCP servers, skills, efficiency rules) and no business code. The project starts clean — ready for OpenCode.

Start OpenCode with the startup prompt:

```bash
opencode --prompt "startup"
# or with the alias configured during installation:
oc
```

OpenCode loads `AGENTS.md`, launches Serena and Context7, and prompts for the first task with token-reducing defaults in place.

---

## Migrate into an Existing Project

To apply the token-reduce template to an existing project, use the `/migrate` command:

```bash
opencode --prompt "/migrate /path/to/your/project"
```

The command clones the template, merges config files into your project, commits, and pushes. **Conflicts may arise** if your project already has an `opencode.json`, `.opencode/`, or `.serena/` directory — the command resolves them by preferring your existing business logic while accepting template tooling config. Review the merge commit before pushing if you want manual control.

Requires git push access to the target repository's remote.

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

## Serena LSP Support

Serena's semantic tools (symbol search, rename, diagnostics) require a language server (LSP) per language. The template pre-configures only **auto-installed** LSPs — Serena downloads these on first use with no manual setup:

| Language     | LSP                  | Auto-installed |
|--------------|----------------------|----------------|
| Python       | pyright              | Yes            |
| TypeScript   | typescript-language-server | Yes (via npm) |
| Java         | eclipse-jdtls        | Yes            |
| C/C++        | clangd               | Yes            |
| Bash         | bash-language-server | Yes            |
| JSON         | json-language-server | Yes            |

Languages **not** in this list require manual LSP installation (e.g. `gopls` for Go, `rust-analyzer` for Rust via rustup). Serena does **not** notify you if a manually-installed LSP is missing — queries silently return empty results.

To add support for another language, edit `languages:` in `.serena/project.yml` and install the required LSP. See the [Serena language support docs](https://oraios.github.io/serena/01-about/020_programming-languages.html) for each language's requirements.

---

## File Layout

```
opencode-token-reduce/
├── opencode.json              # Main config: agent, MCP servers, LSP, commands
├── AGENTS.md                  # Startup, tool discipline, Context7 docs, tone, commit
├── .gitignore
├── .opencode/
│   ├── commands/
│   │   └── migrate.md            # /migrate — merge template into existing project
│   └── skills/
│       └── memory-management/
│           └── SKILL.md
├── .serena/
    ├── .gitignore             # Ignores /cache, /project.local.yml
    ├── project.yml            # Serena project config (languages, encoding, ignored paths)
    └── memories/
        └── .gitkeep           # Placeholder — keeps the directory tracked
```
