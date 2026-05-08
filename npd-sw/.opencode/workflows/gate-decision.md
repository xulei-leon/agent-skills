# Gate Decision Workflow

Record decisions — approve a document, or set a gate for a phase/milestone.

## Data Types

```typescript
interface GateDecision {
  milestone: string;
  status: 'Go' | 'No Go' | 'Hold' | 'Rework';
  submittedAt: string;
  resolvedAt?: string;
  reviewer?: string;
  comments: string[];
  attempt: number;
}
```

## Storage

- File: `.npd-status.json` — `gates` array + `documents[].status` + `phases[].status`

## Steps

### Step 0: Parse Command

Split user input into `target`, `action`, and optional `reason`:

| Input | target | action | reason |
|-------|--------|--------|--------|
| `SRS.md approved` | `SRS.md` | `approved` | — |
| `phase1 go` | `phase1` | `go` | — |
| `M1 rework: missing error handling` | `M1` | `rework` | `missing error handling` |

Determine mode:
- If `target` matches a filename in `.npd-status.json.documents[].path` → **Document Approval** mode
- If `target` starts with `phase` → **Phase Gate** mode
- If `target` matches `M<N>` → **Milestone Gate** mode

---

### Document Approval Mode

### Step D1: Find Document
- Read `.npd-status.json.documents[]`
- Match `target` against `path` using the filename (e.g. `SRS.md` matches `docs/02-Requirement/SRS.md`)

### Step D2: Update Status
- Set `documents[i].status = "Approved"`
- Update `updatedAt` to current timestamp
- Persist to `.npd-status.json`

### Step D3: Output
- Print `[Document Approved] {path} → Approved`
- If this was the last document needed for the current phase, suggest next command

---

### Phase/Milestone Gate Mode

### Step G1: Parse Target
- For `phase<N>`: extract phase id (e.g. `phase1` → id `1`)
- For `M<N>`: milestone identifier (e.g. `M1`)

### Step G2: Submit for Gate Decision
- Look up existing gate for this target in `.npd-status.json.gates[]`
  - If exists: increment `attempt`, reset `status`, clear `comments`
  - If new: create gate with `attempt: 1`
- Persist to `.npd-status.json`

### Step G3: Record Decision
- Set `status` to the action value (`Go` | `No Go` | `Hold` | `Rework`)
- If `action` is `rework`, `hold`, or `nogo`, extract the reason from input (text after `:`)
- Set `resolvedAt`, `comments`, `reviewer`
- Persist

### Step G4: Handle Go
- On `Go`:
  - If target is a phase: mark `phases[id].status = "Completed"`, then scan forward for next enabled phase and recommend its command
  - If target is a milestone: recommend proceeding to next milestone or Phase 4
- Print `[Gate: Go]` with next recommended command

### Step G5: Handle No Go / Hold
- On `No Go` / `Hold`: log reason in `.npd-status.json`
- Print `[Gate: {action}]` with reason
- Project may need restructuring (No Go) or revisit later (Hold)

### Step G6: Handle Rework
- On `Rework`: log failure reason
- If target is a milestone: inform user of remaining attempts (max 3)
- Return to development fix loop (Step 8 in `.opencode/workflows/phase3-develop.md`)

## Usage

```markdown
# Document approval
/npd-decision SRS.md approved
/npd-decision Charter.md approved

# Phase gate
/npd-decision phase1 go
/npd-decision phase2 nogo: architecture not aligned
/npd-decision phase0 hold: need more market research

# Milestone gate
/npd-decision M1 go
/npd-decision M1 rework: missing exception handling
/npd-decision M2 nogo: performance not met
```
