# Migration — `/migrate` command

## Purpose
Apply the opencode-token-reduce template into an existing target project.

## Workflow (defined in `.opencode/commands/migrate.md`)
1. Validate target is a git repo and directory exists.
2. Clone template from `https://github.com/dcerisano/opencode-token-reduce` to temp dir.
3. Merge these files into target:
   - `opencode.json`
   - `AGENTS.md`
   - `.opencode/` (merge — keep existing commands/skills/plugins)
   - `.serena/` (merge — keep existing memories/config)
   - `.gitignore` (append missing entries)
4. Stage, commit (`chore: integrate opencode-token-reduce template`), push.
5. On merge conflicts: prefer target's code for business logic, template's files for tooling.
6. Instruct user to quit/restart OpenCode.

## Agent binding
The command runs under the `build` agent (`temperature: 0.2, top_p: 0.8`).
