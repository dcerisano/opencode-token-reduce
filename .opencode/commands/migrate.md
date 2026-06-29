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

1. Clone template from `https://github.com/dcerisano/opencode-token-reduce` to a temp dir.
2. Merge these files into target:
   - `opencode.json`
   - `AGENTS.md`
   - `.opencode/` (merge — keep existing commands/skills/plugins)
   - `.serena/` (merge — keep existing memories/config)
   - `.gitignore` (append missing entries)
3. Show the user a summary of what changed (files added, modified, conflicted) using `question` to ask for approval before committing.
4. If approved, stage, commit with message `chore: integrate opencode-token-reduce template`, and push. If rejected, abort and leave the working tree as-is.
5. On merge conflicts: prefer target's code for business logic, template's files for tooling.
5. Instruct user to quit/restart OpenCode.