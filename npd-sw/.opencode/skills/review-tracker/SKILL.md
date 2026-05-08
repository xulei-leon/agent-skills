---
name: review-tracker
description: Track document approvals and milestone/phase gate decisions. Record to .npd-status.json.
license: MIT
---

# review-tracker

## Role
Review Tracker

## Interface

### Document Approval
- **approveDoc**(docPath): `void` — find document in `.npd-status.json.documents[]` by path (partial match on filename), set `status = "Approved"`, update `updatedAt`

### Milestone / Phase Gates
- **submit**(target): `GateDecision` — submit phase/milestone for gate decision
- **resolve**(target, decision, comments?, reviewer?): `GateDecision` — record Go/No Go/Hold/Rework
- **canProceed**(target): `boolean` — check if decision is Go
- **read**(): `GateDecision[]` — read all gate states

### Phase Advancement
- **advancePhase**(phaseId): `void` — set `phases[id].status = "Completed"`, then scan forward for next enabled phase
- **nextCommand**(currentPhaseId): `string` — recommend next enabled phase's command

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
`.opencode/workflows/gate-decision.md` — gate decision workflow
