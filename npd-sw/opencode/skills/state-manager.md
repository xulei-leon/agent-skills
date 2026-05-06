# state_manager

## Purpose
Read, write, and advance the NPD-SW Model workflow state (`state.json`).

## Interface
- **read**(path?): `NpdSwState | null` — read state.json
- **write**(state, path?): `void` — persist state.json
- **advance**(targetPhase, subphase): `NpdSwState` — move to next phase
- **markDoc**(docPath): `NpdSwState` — record completed document
- **markMilestone**(milestone): `NpdSwState` — record completed milestone

## State Schema
```json
{
  "project": "string",
  "phase": "Phase0|Phase1|Phase2|Phase3|Phase4",
  "subphase": "string",
  "current_milestone": "M0|M1|M2|M3|M4|N/A",
  "review_status": "pending|approved|rejected",
  "version": "x.y.z",
  "completed_docs": ["path1", "path2"],
  "completed_milestones": ["M1"],
  "git_commits": ["hash"],
  "started_at": "ISO8601",
  "last_updated": "ISO8601"
}
```

## Implementation
已移除（state.json 已删除，不再需要状态管理）
