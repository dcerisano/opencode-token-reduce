# opencode-token-reduce

## ⚠️ WORK IN PROGRESS

Contributions, suggestions, and PRs are welcome!

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing), **Context7** (live 
documentation lookup) and **DCP** (dynamic context pruning).

Use it as a GitHub template to bootstrap new projects with a pre-configured token-reducing environment. The template is model-agnostic — it works with any LLM backend that OpenCode supports.


## Token Reduction

Serena and Context7 reduce token consumption proactively — they prevent context bloat a priori by replacing expensive, full-file operations with targeted, semantic queries. DCP complements this reactively, pruning bloat that has already accumulated. Reduction per SDLC task is cumulative — each phase compounds the reduction by passing less bloat to the next.

| SDLC Task | Without | Serena | Context7 | DCP |
|:---:|:---:|:---:|:---:|:---:|
| **Code Comprehension** | File grep for symbols | `find_symbol`<br>(55-75%) | | Dedup + compress<br>(5-10%) |
| **Documentation Research** | Read docs or stale training | | `query-docs`<br>(65-85%) | Compress<br>(5-10%) |
| **Code Editing** | Rewrite full files manually | `replace_symbol_body`<br>(40-55%) | | Dedup + compress<br>(7-15%) |
| **Search & Debugging** | Grep codebase + manual read | `find_implementations`<br>(45-65%) | | Error pruning + compress<br>(7-15%) |
| **Diagnostics** | Log grep + manual bisect | `get_diagnostics_for_file`<br>(55-75%) | | Compress<br>(5-10%) |
| **Library/Tool Setup** | Read setup guide manually | | `query-docs`<br>(65-85%) | Compress<br>(5-10%) |
| **Refactoring** | Manual rename across files | `rename_symbol`<br>(75-85%) | | Compress<br>(7-15%) |

**Overall projection:** ~80% fewer tokens consumed (total combined net range across all phases, after tool overhead), with the largest reductions in early phases (comprehension, 
research) and refactoring.

---

## Create a New Project from the Template

Create a new empty repository from this GitHub template with a single command:

```bash
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
opencode --prompt "startup"
```

This creates a new repository with the template's full configuration (agents, MCP servers, skills, efficiency rules) and no business code. The project starts clean — ready for OpenCode.

---

## Migrate into an Existing Project

To apply the token-reduce template to an existing project, use the `/migrate` command:

```bash
opencode --prompt "/migrate /path/to/your/project"
```

The command copies the template's config into your project, **overwriting any existing files at those paths**. Review your existing config before running migration, especially if you have custom agents, commands, skills, or MCP server definitions.

All configs are project-scoped — they live in your project root and have no effect outside it. Your global OpenCode configuration (`~/.config/opencode/`) is never touched.

OpenCode bootstraps with Serena, Context7, and DCP  and uses Serena Memories to prime the session. 

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

#DCP
opencode plugin @tarquinen/opencode-dcp@latest --global

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

# DCP
opencode plugin @tarquinen/opencode-dcp@latest --global

# Quick startup alias
function oc { opencode --prompt "startup" }

# Create a new project from this template
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
oc
```

The Serena and Context7 MCP servers are configured in the root `opencode.json` and launch automatically on startup. The Serena web dashboard is available at [http://127.0.0.1:24282/dashboard/index.html](http://127.0.0.1:24282/dashboard/index.html) (auto-launch is disabled to avoid unnecessary tray/browser windows).

---

## Tech Stack

### OpenCode

[OpenCode](https://opencode.ai) handles model selection, MCP server orchestration, agent definitions with granular permission scopes, skill loading, and command templates. Session-level AI instructions are loaded from [`AGENTS.md`](./AGENTS.md).

### Serena

[Serena](https://oraios.github.io/serena/) proactively prevents context bloat by replacing native read/write/grep/glob with semantic operations — symbol search, targeted body replacement, diagnostics retrieval, and batch reads — avoiding full-file reads and reducing context per tool call.

### Context7

[Context7](https://context7.com) proactively prevents context bloat by resolving library names to IDs and returning targeted API references and code examples — avoiding full documentation reads and eliminating reliance on stale training data.

### DCP (Dynamic Context Pruning)

[`@tarquinen/opencode-dcp`](https://github.com/Opencode-DCP/opencode-dynamic-context-pruning) is an OpenCode plugin that provides reactive context management: compression nudge reminders at configurable context thresholds, message deduplication, error pruning, and turn protection. Configured in `.opencode/dcp.jsonc` with percentage-based limits that auto-scale per model.

---

## Migrated Files

Files copied by `/migrate` into the target project:

```
opencode-token-reduce/
├── opencode.json
├── AGENTS.md
├── .opencode/
│   ├── .gitignore
│   ├── dcp.jsonc
│   ├── commands/
│   │   └── migrate.md
│   └── skills/
│       ├── bootstrap/
│       │   └── SKILL.md
│       ├── detect-languages/
│       │   └── SKILL.md
│       └── memory-management/
│           └── SKILL.md
├── .serena/
│   ├── .detected-languages.sig
│   └── .gitignore
```

`README.md`, `.serena/project*.yml`, and all files under `.serena/memories/` are excluded from migration — they are template metadata, not project config.
