# Evaluations for managing-vibe-sessions

This directory contains evaluation results for the managing-vibe-sessions skill.

## Evaluation Approach

Since this is a workflow/orchestration skill rather than a data-processing skill, evaluations are **behavioral** and require **human judgment**. We test:

- Does Claude recognize when to use the skill?
- Does it properly invoke automation scripts?
- Does it use injected context effectively?
- Does it update planning files appropriately?
- Are closeouts and ADRs meaningful?

## How to Evaluate

1. **Copy the template**:
   ```bash
   cp EVALUATION_TEMPLATE.md evaluation-$(date +%Y-%m-%d).md
   ```

2. **Run through each test scenario**:
   - Set up the test conditions
   - Execute the query
   - Observe Claude's behavior
   - Check all expected behaviors
   - Mark PASS/PARTIAL/FAIL
   - Document what happened

3. **Test across models**:
   - Haiku 4.5 (fast, economical)
   - Sonnet 4.5 (balanced)
   - Opus 4.6 (powerful reasoning)

4. **Document findings**:
   - What worked well?
   - What needs improvement?
   - Any surprising behavior?
   - Recommended changes?

## What We're Testing

### Core Functionality
- Session start (`/vibe start`)
- Session status (`/vibe status`)
- Session close (`/vibe close`)

### Hook Behavior
- SessionStart: Context injection
- PreToolUse: Progress reminders
- PostToolUse: Update suggestions
- PreCompact: Context re-injection

### User Experience
- Command discovery
- Context escalation suggestions
- Error handling
- Documentation quality

### Context Management
- Trust injected context vs manual reads
- Update planning files appropriately
- Generate meaningful ADRs
- Keep context file updates minimal

## Evaluation History

- **EVALUATION_TEMPLATE.md** - Template for new evaluations
- [Add completed evaluations here as they're done]

## Continuous Improvement

After each evaluation:
1. Update planning files with findings
2. Fix critical issues
3. Document decisions
4. Re-test affected scenarios
5. Include evaluation in ADR on feature close

## Why Manual Testing?

Automated testing of behavioral/workflow skills is challenging because we're testing:
- Decision quality (did Claude make the right choice?)
- Context usage (did it use injected context effectively?)
- Update appropriateness (are planning file updates helpful?)
- Output quality (are ADRs meaningful?)

These require human judgment. As the skill matures and patterns stabilize, we may be able to create more automated tests.
