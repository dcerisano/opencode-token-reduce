---
name: bootstrap
description: Use on session start (only) to perform the Opencode Token Reduce bootstrap sequence — serena memory loading, context7 resolution, compression, and confidence test reporting. Do not use for other purposes.
---

Run these steps SEQUENTIALLY IN ORDER. DO NOT SKIP ANY. DO NOT REPEAT STEPS. DO NOT COMMENT ON STEPS. BOOTSTRAP OUTPUT MUST BE DETERMINISTIC WOTH NONE OF YOUR CHATTER.


1. Call `serena_initial_instructions` then `serena_list_memories` then `serena_read_memory("mem:core")`.

2. Launch a subagent (`subagent_type="general"`) that:
   2.1. Loads the `detect-languages` skill via `skill("detect-languages")` and
        executes its steps.
   2.2. Calls `context7_resolve-library-id("serena")`.
   2.3. Returns: whether languages changed (and the list), and the context7
        library ID.

3. Call `compress` on the range covering the subagent's task output (but NOT
   the mem:core read from step 1).

4. Output the confidence test results as 5 single spaced lines of plain text: 
   4.1. If `compress` ran: "Compress confidence test PASSED."
   4.2. If a 'Compressed conversation section' appeared in session: "DCP confidence test PASSED."
   4.3. If subagent returned a context7 library id: "Context7 confidence test PASSED."
   4.4. If `mem:core` was read: "Serena confidence test PASSED."
   4.5. If all passed: "Opencode Token Reduce BOOTSTRAP PASSED."
