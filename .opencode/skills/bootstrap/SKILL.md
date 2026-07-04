---
name: bootstrap
description: Use on session start (only) to perform the Opencode Token Reduce bootstrap sequence — serena memory loading, context7 resolution, compression, and confidence test reporting. Do not use for other purposes.
---

Run these steps SEQUENTIALLY IN ORDER. NO PARALLEL STEPS.
DO NOT SKIP ANY. DO NOT REPEAT STEPS. DO NOT COMMENT ON STEPS. BOOTSTRAP OUTPUT MUST BE DETERMINISTIC WOTH NONE OF YOUR CHATTER.


1. Call `serena_initial_instructions` and return boolean  <onboarded> set true if onboarding has already happened, false if not.

2. Call the following in a subagent with <onboarded> passed in:
   2.1  If not <onboarded> call serena onboarding.
   2.2. Call `detect-languages` skill when onboarding completes.
   2.3. Call `context7_resolve-library-id("serena")` tool
   2.4. Return a JSON object with keys: `context7LibraryId` (string), `languages` (array of strings), `languagesChanged` (bool).

3. Call `compress`.

4. Output the confidence test results as 6 single spaced lines of plain text: 
   4.1. If `compress` ran: "Compress confidence test PASSED."
   4.2. If a 'Compressed conversation section' appeared in session: "DCP confidence test PASSED."
   4.3. If the subagent returned a context7 library id: "Context7 confidence test PASSED."
   4.4. If `serena_initial_instructions` succeeded: "Serena confidence test PASSED."
   4.5. If the subagent returned a languages array with at least one entry: "Language detection confidence test PASSED."
   4.6. If all passed: "Opencode Token Reduce BOOTSTRAP PASSED."

5. If `languagesChanged` is true, output: "New languages detected — restart opencode for serena LSPs to activate."
