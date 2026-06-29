---
description: OpenCode token-reduce template into an existing project
agent: build
---

You are migrating the opencode-token-reduce template into the existing project at `$ARGUMENTS`.

1. Verify the path exists, is a directory, and is a git repository.
2. Clone the template from `https://github.com/dcerisano/opencode-token-reduce` into a temporary directory.
3. Copy these template files into the target project, preserving any existing files the target already has:
   - `opencode.json`
   - `AGENTS.md`
   - `.opencode/` (merge — do not overwrite existing commands, skills, or plugins the target owns)
   - `.serena/` (merge — keep existing memories and config)
   - `.gitignore` (append template entries if not present)
4. Stage all changes in the target repo, commit with message `chore: integrate opencode-token-reduce template`, and push.
5. If merge conflicts arise during push, resolve them by accepting both sides where reasonable (prefer the target's existing code for business logic; prefer the template's files for tooling config). Complete the merge commit and push.

After completion, tell the user to quit and restart opencode for the new config to take effect.
