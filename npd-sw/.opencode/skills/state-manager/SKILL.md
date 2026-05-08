---
name: state-manager
description: Track NPD-SW project phase transitions, document completion, and milestone status.
license: MIT
---

# state-manager

## Role
State Manager

## Interface
- **advance**(targetPhase, subphase): move to next phase
- **markDoc**(docPath): record completed document
- **markMilestone**(milestone): record completed milestone
- **approveDoc**(docPath): `void` — set document status to "Approved" in `.npd-status.json.documents[]`
- **nextCommand**(currentPhaseId): `string` — scan forward through phases, skip `enable: false`, return the first non-completed phase's command

## Implementation
State tracking is through `.npd-status.json` and sprint/backlog.md.
