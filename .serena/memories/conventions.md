# Conventions

## Code Style
- JSON files: 2-space indentation (see opencode.json)
- Markdown: standard GFM, no hard wraps
- Config files at project root: opencode.json, AGENTS.md

## Serena Memory Conventions
- Reference format: `` `mem:<name>` `` with surrounding text indicating when to read
- Dense agent notes — no prose, no rationale, no examples unless needed to prevent mistakes
- Add/update threshold: only stable, non-obvious project conventions that prevent rediscovery
- Graph model: core → focused memories → sub-memories by topic/module

## Tool Usage (from AGENTS.md)
- Serena preferred over grep/glob for all code analysis
- Context7 preferred over webfetch for docs
- Bootstrap skill loaded on session start (after "Opencode Token Reduce BOOTSTRAP" report)
- `compress` tool is primary context management mechanism
- Subagent (`subagent_type="general"`) for writing serena memories
- Ignore messages starting with "/" (shell/plugin commands)
- Never modify global config (`~/.config/opencode/`)
