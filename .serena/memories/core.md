# opencode-token-reduce — Core

Drop-in OpenCode configuration template that reduces AI token usage by pairing Serena (efficient code analysis/editing) with Context7 (live documentation lookup) under strict efficiency rules. Used as a GitHub template to bootstrap new projects.

## Source map

```
opencode.json              # Main config: agent, MCP servers, LSP, commands
AGENTS.md                  # Startup, tool discipline, skill-based memory management
.opencode/
  package.json             # Plugin dependency
  skills/
    memory-management/     # Skill for creating/updating Serena memories
.serena/
  project.yml              # Serena project config (languages, encoding, no-onboarding)
  project.local.yml        # Local overrides (gitignored)
  cache/                   # Serena cache (gitignored)
  memories/                # Serena memories — tracked in git, committed on creation
```

## Key invariants

- AGENTS.md startup steps execute before any other action
- `no-onboarding` mode set in Serena config — onboarding disabled, agent creates memories via skill
- Native `edit` and `write` tools denied in opencode.json — all code modifications use Serena tools
- Two MCP servers: Serena (local, via uvx) and Context7 (remote)

## References

- `mem:tech_stack` — language and tooling details