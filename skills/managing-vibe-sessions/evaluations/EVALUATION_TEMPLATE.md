# Evaluation Template for managing-vibe-sessions

Use this template to manually test the skill's behavior. Copy this file for each evaluation run (e.g., `evaluation-2026-02-16.md`).

**Tester**: [Your name]
**Date**: [YYYY-MM-DD]
**Claude Model**: [Opus 4.6 / Sonnet 4.5 / Haiku 4.5]
**Skill Version**: [commit hash or version]

---

## Test 1: Session Start from Cold State

**Scenario**: User wants to start work on a new feature

**Setup**:
- No active vibe session
- No `.vibe/active-feature` file
- Empty or no `features/` directory

**Query**: "I want to add user authentication to my app. Help me plan this out."

**Expected Behavior**:
- [ ] Claude suggests starting a vibe session
- [ ] Uses `/vibe start` command (not `/vibepilot start`)
- [ ] Calls `vibe-start` script with appropriate feature name
- [ ] Confirms workspace creation at `features/<feature-name>/`
- [ ] Helps fill out `OVERVIEW.md` with scope, goals, and questions
- [ ] Helps create initial `PLAN.md` with phases and tasks
- [ ] Mentions that hooks will inject context on next session

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [What worked? What didn't? Unexpected behavior?]

---

## Test 2: Working with Injected Context

**Scenario**: Continuing work in an active vibe session where SessionStart hook has injected context

**Setup**:
- Active vibe session exists (`features/user-auth/`)
- `.vibe/active-feature` contains "user-auth"
- Planning files exist with content
- SessionStart hook fired and injected feature context

**Query**: "Let's implement the login endpoint now"

**Expected Behavior**:
- [ ] References the injected feature context without manually reading planning files
- [ ] Shows awareness of current plan/progress from injected context
- [ ] Implements the login endpoint
- [ ] Updates `PROGRESS.md` to note what was completed
- [ ] Adds key decisions to `DECISIONS.md` if applicable
- [ ] Does not duplicate context reading (trusts the hooks)

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Did Claude trust the injected context? Did it update planning files appropriately?]

---

## Test 3: Session Closeout

**Scenario**: User is done with feature work and wants to close the session

**Setup**:
- Active vibe session with completed work
- Planning files contain progress, decisions, and plan updates
- Some code changes were made

**Query**: "/vibe close"

**Expected Behavior**:
- [ ] Calls `vibe-close` script
- [ ] Reviews the generated ADR for completeness
- [ ] Identifies context file updates needed (architecture.md, agents.md, product.md)
- [ ] Makes minimal, precise updates to context files (if needed)
- [ ] Does not add verbose/chatty documentation
- [ ] Confirms closeout to user with ADR location
- [ ] Shows workspace is preserved at `features/<feature-name>/`

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Was the ADR meaningful? Were context updates minimal and precise?]

---

## Test 4: Context Escalation Suggestion

**Scenario**: User starts working on something complex without a vibe session

**Setup**:
- No active vibe session
- User is 10+ messages into a complex conversation
- Multiple decisions being made, files being changed

**Query**: "Now let's also refactor the authentication system, update the database schema, add OAuth support, and implement refresh tokens"

**Expected Behavior**:
- [ ] Recognizes this is substantial/complex work
- [ ] Suggests starting a vibe session with `/vibe start`
- [ ] Suggestion is polite, not pushy
- [ ] Does not force the issue if user continues without starting session
- [ ] Only suggests once (does not nag repeatedly)

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Was the suggestion appropriate? Too early? Too late? Not made at all?]

---

## Test 5: Status Check

**Scenario**: User wants to see current vibe session state

**Setup**:
- Active vibe session with some progress made
- Planning files have been updated during work

**Query**: "/vibe status"

**Expected Behavior**:
- [ ] Calls `vibe-status` script
- [ ] Shows active feature name
- [ ] Shows session start time and description
- [ ] Shows recent progress from `PROGRESS.md`
- [ ] Shows plan completion status (tasks done/total)
- [ ] Shows workspace location
- [ ] Reminds user about `/vibe close` command

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Was the status output helpful? Missing anything important?]

---

## Test 6: Hook Behavior - PreToolUse

**Scenario**: Claude is about to make significant code changes during an active session

**Setup**:
- Active vibe session
- About to execute Write/Edit/Bash command
- PreToolUse hook should fire

**Query**: "Create the login endpoint in src/api/auth.js"

**Expected Behavior**:
- [ ] PreToolUse hook shows reminder of current progress
- [ ] Claude acknowledges the context refresh
- [ ] Proceeds with the implementation
- [ ] Hook output is concise and relevant

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Did the hook fire? Was the reminder helpful or distracting?]

---

## Test 7: Hook Behavior - PostToolUse

**Scenario**: Claude just made significant file changes

**Setup**:
- Active vibe session
- Just executed Write/Edit tool on a non-planning file
- PostToolUse hook should fire

**Query**: [After implementing something]

**Expected Behavior**:
- [ ] PostToolUse hook suggests updating progress
- [ ] Suggestion is gentle, not pushy
- [ ] Claude may or may not act on the suggestion (context dependent)
- [ ] Hook output is concise

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Did the hook fire? Did Claude update PROGRESS.md appropriately?]

---

## Test 8: Hook Behavior - PreCompact

**Scenario**: Context window is filling up and approaching compaction

**Setup**:
- Active vibe session
- Context window approaching compaction threshold
- PreCompact hook should fire

**Query**: [Continue working on feature]

**Expected Behavior**:
- [ ] PreCompact hook re-injects feature context
- [ ] Shows OVERVIEW, recent PROGRESS, and DECISIONS
- [ ] Claude continues work with fresh context
- [ ] No loss of awareness about current feature

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Hard to test without triggering real compaction. May need to verify by reading code.]

---

## Test 9: Error Handling - No Active Session

**Scenario**: User tries to close or check status without an active session

**Setup**:
- No active vibe session
- No `.vibe/active-feature` file

**Query**: "/vibe close"

**Expected Behavior**:
- [ ] Script returns error message
- [ ] Claude shows error to user
- [ ] Suggests starting a session with `/vibe start`
- [ ] Does not crash or create malformed data

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Was the error message clear and helpful?]

---

## Test 10: Context File Updates

**Scenario**: Feature introduces new patterns that affect context files

**Setup**:
- Active vibe session implementing new architectural patterns
- Changes affect `architecture.md` or `agents.md`
- Ready to close session

**Query**: "/vibe close"

**Expected Behavior**:
- [ ] Closeout script flags context file updates needed
- [ ] Claude identifies specific sections to update
- [ ] Updates are minimal and precise (not verbose)
- [ ] Updates justify their token cost
- [ ] No chatty explanations or redundant content

**Actual Result**: [What happened?]

**Status**: ⬜ PASS / ⬜ PARTIAL / ⬜ FAIL

**Notes**: [Were context updates appropriate? Too verbose? Too minimal?]

---

## Summary

**Overall Pass Rate**: [X/10 tests passed]

**Model Performance**: [How did this model handle the skill?]

**Critical Issues**: [Any blockers or major problems?]

**Nice Surprises**: [What worked better than expected?]

**Improvement Areas**: [What needs work?]

**Recommended Changes**: [Specific changes to SKILL.md, hooks, or scripts]

---

## Next Steps

After completing this evaluation:

1. Update `features/initial-development/planning/PROGRESS.md` with findings
2. Add any critical issues to `features/initial-development/planning/DECISIONS.md`
3. If changes needed, document in planning files before implementing
4. Re-test after changes
5. Include this evaluation in the ADR when closing the feature
