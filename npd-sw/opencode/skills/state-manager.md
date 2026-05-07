# state-manager

## Role
State Manager

## Interface
- **advance**(targetPhase, subphase): move to next phase
- **markDoc**(docPath): record completed document
- **markMilestone**(milestone): record completed milestone

## Implementation
State tracking is through `.npd-status.json` and sprint/backlog.md.
