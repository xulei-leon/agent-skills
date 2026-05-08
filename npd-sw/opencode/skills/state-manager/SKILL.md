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

## Implementation
State tracking is through `.npd-status.json` and sprint/backlog.md.
