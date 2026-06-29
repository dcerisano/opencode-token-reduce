---
description: OpenCode token-reduce template into an existing project
agent: build
---

Ask the user for a target directory path using the `question` tool. Keep asking until the user provides a path that:
1. Exists as a directory (`bash` with `test -d "$path"`)
2. Is a git repository (`bash` with `git -C "$path" rev-parse --git-dir`)

Once a valid path is confirmed, proceed with the full migration workflow below.

Delegate the full workflow to a `task` subagent (type `general`) so output is collapsed. Pass the confirmed path as the target.

The subagent receives:

You are migrating the opencode-token-reduce template into the existing project at `{confirmed_path}`.

1. Copy these files from the current repo into target (do NOT copy README.md or any `memory.md` files):
2. Merge into target:
   - `opencode.json`
   - `.opencode/` (merge — keep existing commands/skills/plugins)
   - `.serena/` (merge — keep existing memories/config)
   - `.gitignore` (append missing entries)
3. Show the user a summary of what changed (files added, modified, conflicted).
4. Stage all changes. Inform the user the changes are staged and ready for review/testing. Do NOT commit or push — the user will handle that manually.
5. On merge conflicts: prefer target's code for business logic, template's files for tooling.
5. Instruct user to quit/restart OpenCode.