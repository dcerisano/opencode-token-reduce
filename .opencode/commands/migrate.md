---
description: OpenCode token-reduce template into an existing project
agent: build
---

Check if a target directory path was already provided as an argument in the user's message (e.g. `/migrate /some/path`). If so, use that path directly. Otherwise, ask the user for a target directory path using the `question` tool.

In either case, validate the path exists as a directory using `bash` with `test -d "$path"`. Keep asking (or reject the provided arg) until a valid existing directory is confirmed.

Once confirmed, delegate the full workflow to a `task` subagent (type `general`) so output is collapsed. Pass the confirmed path as the target.

The subagent receives:

You are migrating the opencode-token-reduce template into the existing target project at `{confirmed_path}`.

1. Copy all files from the current remote template repo into target project (EXCEPT DO NOT COPY the README.md or .serena/memory/*.md or .serena/project*.yaml)
2. Merge (don't just replace) any target files already present in the target project giving the migrating file content predecence in the merge
3. Abort and report if any merges had conflicts you could not resolve.
