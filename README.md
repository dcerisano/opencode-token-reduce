# opencode-token-reduce

## ⚠️ WORK IN PROGRESS

Contributions, suggestions, and PRs are welcome!

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing) with **Context7** (live documentation lookup) under strict efficiency rules.

Use it as a GitHub template to bootstrap new projects with a pre-configured token-reducing environment. The template is model-agnostic — it works with any LLM backend that OpenCode supports.

The template includes [`AGENTS.md`](./AGENTS.md) — a system prompt loaded automatically by OpenCode on every session. It instructs the AI to be concise, prefer Serena for code analysis, use Context7 for documentation, and run a startup routine (`context7_resolve-library-id`, read all Serena memories) each session.

## Token Savings

Serena and Context7 reduce token consumption proactively — they prevent context bloat a priori by replacing expensive, full-file operations with targeted, semantic queries. DCP complements this reactively, pruning bloat that has already accumulated.

<table>
<tr>
  <th align="center">SDLC Phase</th>
  <th align="center">Without</th>
  <th align="center">Serena</th>
  <th align="center">Context7</th>
  <th align="center">DCP</th>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Code Comprehension</strong></td>
  <td align="center" valign="top">File grep for symbols</td>
  <td align="center"><code>find_symbol</code><br>(55-75%)</td>
  <td align="center"></td>
  <td align="center">Dedup + compress<br>(5-10%)</td>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Documentation Research</strong></td>
  <td align="center" valign="top">Read docs or stale training</td>
  <td align="center"></td>
  <td align="center"><code>query-docs</code><br>(65-85%)</td>
  <td align="center">Compress<br>(5-10%)</td>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Code Editing</strong></td>
  <td align="center" valign="top">Rewrite full files manually</td>
  <td align="center"><code>replace_symbol_body</code><br>(40-55%)</td>
  <td align="center"></td>
  <td align="center">Dedup + compress<br>(7-15%)</td>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Search & Debugging</strong></td>
  <td align="center" valign="top">Grep codebase + manual read</td>
  <td align="center"><code>find_implementations</code><br>(45-65%)</td>
  <td align="center"></td>
  <td align="center">Error pruning + compress<br>(7-15%)</td>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Diagnostics</strong></td>
  <td align="center" valign="top">Log grep + manual bisect</td>
  <td align="center"><code>get_diagnostics_for_file</code><br>(55-75%)</td>
  <td align="center"></td>
  <td align="center">Compress<br>(5-10%)</td>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Library/Tool Setup</strong></td>
  <td align="center" valign="top">Read setup guide manually</td>
  <td align="center"></td>
  <td align="center"><code>query-docs</code><br>(65-85%)</td>
  <td align="center">Compress<br>(5-10%)</td>
</tr>
<tr valign="bottom">
  <td align="center" valign="top"><strong>Refactoring</strong></td>
  <td align="center" valign="top">Manual rename across files</td>
  <td align="center"><code>rename_symbol</code><br>(75-85%)</td>
  <td align="center"></td>
  <td align="center">Compress<br>(7-15%)</td>
</tr>
</table>

**Overall projection:** 50-85% fewer tokens consumed (total combined net range across all phases, after tool overhead), with the largest gains in early phases (comprehension, research) and refactoring.

DCP acts as a reactive complementary layer — it prunes conversation context via compression nudges, deduplication, and error pruning, cleaning up token waste that has already accumulated across multi-turn sessions. Together, the three tools form a complete token-reduction pipeline: Serena and Context7 prevent bloat a priori for code and docs, while DCP reactively cleans up conversation state.

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
