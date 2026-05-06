# review-tracker

## Purpose
Track review gate submissions, approvals, rejections, and attempt counts.

## Interface
- **submit**(milestone): `ReviewGate` — submit milestone for review
- **resolve**(milestone, resolution, comments?, reviewer?): `ReviewGate` — pass/fail
- **canProceed**(milestone): `boolean` — check if review passed
- **read**(): `ReviewGate[]` — read all gate states

## Gate Schema
```json
{
  "milestone": "M1",
  "status": "pending|submitted|passed|failed",
  "submittedAt": "ISO8601",
  "resolvedAt": "ISO8601",
  "reviewer": "string",
  "comments": ["string"],
  "attempt": 1
}
```

## Constraints
- Max 3 failed attempts per milestone
- Can only proceed after `passed` status
- All rejection reasons must be logged

## Implementation
`opencode/workflows/gate-decision.md` — gate decision workflow
