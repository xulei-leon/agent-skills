---
name: review-tracker
description: Track milestone gate decisions with submit, resolve, and status check operations.
license: MIT
---

# review-tracker

## Role
Review Tracker

## Interface
- **submit**(milestone): `GateDecision` — submit milestone for gate decision
- **resolve**(milestone, decision, comments?, reviewer?): `GateDecision` — record Go/No Go/Hold/Rework
- **canProceed**(milestone): `boolean` — check if decision is Go
- **read**(): `GateDecision[]` — read all gate states

## Gate Schema
```json
{
  "milestone": "M1",
  "status": "Go|No Go|Hold|Rework",
  "submittedAt": "ISO8601",
  "resolvedAt": "ISO8601",
  "reviewer": "string",
  "comments": ["string"],
  "attempt": 1
}
```

## Constraints
- Max 3 `Rework` attempts per milestone
- Can only proceed after `Go` status
- All rejection reasons must be logged in `.npd-status.json`

## Implementation
`opencode/workflows/gate-decision.md` — gate decision workflow
