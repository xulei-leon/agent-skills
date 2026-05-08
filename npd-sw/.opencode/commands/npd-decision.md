# /npd-decision

## Goal
Record a review decision — approve a document, or set a gate for a phase/milestone.

## Parameters

```
/npd-decision <target> <action> [reason]
```

| Target | Example | Meaning |
|--------|---------|---------|
| filename | `SRS.md`, `Charter.md` | Approve a document |
| `phase<N>` | `phase0`, `phase1` | Gate for a phase |
| `M<N>` | `M1`, `M2` | Gate for a milestone |

| Action | Meaning |
|--------|---------|
| `approved` / `go` | Mark as passed |
| `rework: <reason>` | Needs fixes |
| `hold: <reason>` | Deferred |
| `nogo: <reason>` | Rejected |

## Examples

```
/npd-decision SRS.md approved
/npd-decision phase1 go
/npd-decision M1 rework: missing exception handling
/npd-decision phase2 nogo: architecture not aligned
```

## Workflow
`.opencode/workflows/gate-decision.md`

## Constraints
- Never auto-approve — always wait for explicit user signal
- Log every No Go / Rework / Hold reason
- Max 3 Rework attempts per milestone
