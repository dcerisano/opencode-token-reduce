---
description: OpenCode token-reduce template into an existing project
agent: build
---

If no path was provided with `/migrate`, or the provided path is blank, or it's not a valid git repo (`test -d "$path/.git"` fails), ask the user for the target path using the `question` tool. Keep asking until a non-blank path pointing to a separate git repo is confirmed.

Once confirmed, delegate the full workflow to a `task` subagent (type `general`). Pass the confirmed path as the target.

The subagent receives:

You are migrating the opencode-token-reduce template into the existing target project at `{confirmed_path}`.

1. Copy all files from the current remote template repo into target project (EXCEPT DO NOT COPY the README.md or .serena/memory/*.md or .serena/project*.yaml)
2. Merge (don't just replace) any target files already present in the target project giving the migrating file content predecence in the merge
3. Abort and report if any merges had conflicts you could not resolve.
