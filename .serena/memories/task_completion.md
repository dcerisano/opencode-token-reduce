# Task Completion Checklist

When a coding task is considered complete, run these commands:

1. **Generate code** (if Python model changed):
   `python3 tools/langgraph_to_proto.py tools/multi_agent.py proto/research/v1/research_agent.proto src/test/java/research/v1/McpProtoTest.java`

2. **Full build** (generates, compiles, tests):
   `./build.sh`
   
   If BUF_TOKEN is not available, the buf push step is skipped (non-fatal).

3. **Verify tests pass** — 4 test classes:
   - `research.v1.McpProtoTest` (proto serialization)
   - `research.v1.McpUnitTest` (in-process hermetic)
   - `research.v1.McpIntegrationTest` (live gRPC + LLM — requires llama-server)
   - `research.v1.McpHttpTransportTest` (HTTP transport)
   
   Integration tests are skipped if llama-server is not running.

4. **No lint/formatter** — the project does not have a linter or formatter for Java. Proto formatting is handled by `buf format -w` (already part of build.sh).

If you only changed Python (tools/) or Java impl files (not the Python model), regeneration may not be needed — just compile and test the relevant tier.

## Bootstrap skill (bootstrap/SKILL.md)
- Step 1: green echo "Opencode Token Reduce BOOTSTRAP"
- Step 2: detect-languages (green echo if new languages detected)
- Step 3: list memory names + read `mem:core` only (no more read-all dump)
- Step 4: context7_resolve-library-id("serena")
- Step 5: compress
- Steps 6-9: green echo for each confidence test (Compress, DCP, Context7, Serena)
- Step 10: green echo "Opencode Token Reduce BOOTSTRAP PASSED."
- Memory updates section: use subagent for serena_write_memory to suppress output