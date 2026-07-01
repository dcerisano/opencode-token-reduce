# opencode-token-reduce

## ⚠️ WORK IN PROGRESS

Contributions, suggestions, and PRs are welcome!

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing) with **Context7** (live documentation lookup) under strict efficiency rules.

Use it as a GitHub template to bootstrap new projects with a pre-configured token-reducing environment. The template is model-agnostic — it works with any LLM backend that OpenCode supports.

The template includes [`AGENTS.md`](./AGENTS.md) — a system prompt loaded automatically by OpenCode on every session. It instructs the AI to be concise, prefer Serena for code analysis, use Context7 for documentation, and run a startup routine (`context7_resolve-library-id`, read all Serena memories) each session.

## Token Savings

Serena, Context7, and DCP reduce token consumption across every phase of the SDLC by replacing expensive, full-file operations with targeted, semantic queries and proactive context management.

| SDLC Phase | Without | Serena | Context7 | DCP |
|---|---|---|---|---|
| **Code Comprehension** | Read entire files for relevant symbols | `get_symbols_overview` + `find_symbol` (60-80%) | — | Compress + dedup (5-10%) |
| **Documentation Research** | Read full docs or use stale training data | — | `context7_query-docs` (70-90%) | Compress (5-10%) |
| **Code Editing** | Read full file, rewrite via regex/sed | `replace_symbol_body` / `insert_after_symbol` (40-60%) | — | Compress + dedup (10-20%) |
| **Search & Debugging** | grep/glob across codebase, read to understand | `find_referencing_symbols` / `find_implementations` (50-70%) | — | Compress + error pruning (10-20%) |
| **Diagnostics** | grep logs, manual bisect | `get_diagnostics_for_file` (60-80%) | — | Compress (5-10%) |
| **Library/Tool Setup** | Read setup guide, guess config | — | `context7_query-docs` (70-90%) | Compress (5-10%) |
| **Refactoring** | Find all usages manually, edit each file | `rename_symbol` (80-90%) | — | Compress (10-20%) |

**Overall projection:** 50-70% fewer tokens consumed over the lifespan of a professional-grade project, with the largest gains in early phases (comprehension, research) and refactoring.

DCP acts as a complementary layer — it proactively manages conversation context via compression nudges, deduplication, and error pruning, reducing token waste that accumulates across multi-turn sessions. Together, the three tools form a complete token-reduction pipeline: Serena for code, Context7 for docs, DCP for conversation state.

---

## Create a New Project from the Template

Create a new empty repository from this GitHub template with a single command:

```bash
gh repo create my-project --template dcerisano/opencode-token-reduce --public --clone
cd my-project
opencode --prompt "startup"
```

This creates a new repository with the template's full configuration (agents, MCP servers, skills, efficiency rules) and no business code. The project starts clean — ready for OpenCode.

OpenCode launches Serena and Context7, and prompts for the first task with token-reducing defaults in place.

---

## Migrate into an Existing Project

To apply the token-reduce template to an existing project, use the `/migrate` command:

```bash
opencode --prompt "/migrate /path/to/your/project"
```

The command copies the template's config files (`opencode.json`, `.opencode/`, `.serena/`) into your project, **overwriting any existing files at those paths**. Review your existing config before running migration, especially if you have custom agents, commands, skills, or MCP server definitions.

All configs are project-scoped — they live in your project root and have no effect outside it. Your global OpenCode configuration (`~/.config/opencode/`) is never touched.

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

The Serena and Context7 MCP servers are configured in the root `opencode.json` and launch automatically on startup. The Serena web dashboard is available at [http://127.0.0.1:24282/dashboard/index.html](http://127.0.0.1:24282/dashboard/index.html) (auto-launch is disabled to avoid unnecessary tray/browser windows).

---

## Tech Stack

### OpenCode

[OpenCode](https://opencode.ai) handles model selection, MCP server orchestration, agent definitions with granular permission scopes, skill loading, and command templates. Session-level AI instructions are loaded from [`AGENTS.md`](./AGENTS.md).

### Serena

[Serena](https://oraios.github.io/serena/) replaces native read/write/grep/glob with semantic operations — symbol search, targeted body replacement, diagnostics retrieval, and batch reads — reducing context per tool call.

### Context7

[Context7](https://context7.com) resolves library names to IDs and returns up-to-date API references and code examples, eliminating reliance on stale training data.

### DCP (Dynamic Context Pruning)

[`@tarquinen/opencode-dcp`](https://github.com/Opencode-DCP/opencode-dynamic-context-pruning) is an OpenCode plugin that provides proactive context management: compression nudge reminders at configurable context thresholds, message deduplication, error pruning, and turn protection. Configured in `.opencode/dcp.jsonc` with percentage-based limits that auto-scale per model.

---

## Migrated Files

Files copied by `/migrate` into the target project:

```
opencode-token-reduce/
├── opencode.json
├── AGENTS.md
├── .opencode/
│   ├── .gitignore
│   ├── package.json
│   ├── dcp.jsonc
│   ├── commands/
│   │   └── migrate.md
│   └── skills/
│       └── memory-management/
│           └── SKILL.md
├── .serena/
│   ├── .gitignore
│   └── memories/
│       └── .gitkeep
```

`README.md`, `.serena/project*.yml`, and `.serena/memories/*.md` are excluded from migration — they are template metadata, not project config.
