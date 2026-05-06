# /review-gate

## Goal
Process a review gate decision for a milestone or phase.

## Instructions

### Step 1: Parse User Input
- Detect signal:
  - `Phase {N} Approved` → advance to next phase
  - `Review Passed: M{n}` → advance to next milestone
  - `Review Failed: {reason}` → initiate fix loop

### Step 2: Handle Approval
- Use the `state_manager` skill to update phase/milestone and review_status
- If Phase approval: advance to next phase's first command
- If Milestone approval: advance to M{n+1}, run `/phase3-develop`

### Step 3: Handle Failure
- Use the `state_manager` skill to set `review_status: rejected`
- Log the failure reason
- Return to the appropriate development command for fixes

### Step 4: Track Attempts
- Use the `review_tracker` skill to record attempt count
- If attempt >= 3 on same milestone: warn user, proceed anyway

## Constraints
- Never auto-approve — always wait for explicit user signal
- Log every Review Failed reason in state
- Max 3 failed attempts per milestone
