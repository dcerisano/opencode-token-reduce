---
description: OpenCode token-reduce template into an existing project
agent: build
---

Ask the user for a target directory path using the `question` tool. Keep asking until the user provides a path that:
1. Exists as a directory (`bash` with `test -d "$path"`)

Delegate the full workflow to a `task` subagent (type `general`) so output is collapsed. Pass the confirmed path as the target.

The subagent receives:

You are migrating the opencode-token-reduce template into the existing target project at `{confirmed_path}`.

1. Copy all files from the current remote template repo into target project (except DO NOT copy the README.md):
