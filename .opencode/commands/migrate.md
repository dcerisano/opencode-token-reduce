---
description: OpenCode token-reduce template into an existing project
agent: build
---

Extract the path from the prompt (the argument after `/migrate`) and expand `~`. If the path is non-blank and `test -d "$path/.git"` succeeds, skip asking and proceed. Otherwise, ask the user for the target path using the `question` tool. Keep asking until a non-blank path pointing to a separate git repo is confirmed.

Once confirmed, delegate the full workflow to a `task` subagent (type `general`). Pass the confirmed path as the target.

The subagent receives:

You are migrating the opencode-token-reduce template into the existing target project at `{confirmed_path}`.

1. Copy onlt the git-tracked files from the current local repo into target project (EXCEPT DO NOT COPY the README.md or .serena/memory/*.md or 
.serena/project*.yaml)
2. Merge (don't just replace) any target files already present in the target project giving the migrating file content predecence in the merge
3. Abort and report if any merges had conflicts you could not resolve.
4. Do not track stage commit or push the copied files. just copy and merge them directly do not use git CLI for anything
