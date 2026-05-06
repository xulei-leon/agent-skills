# Gate Decision Workflow

Track milestone/phase gate decisions: Go, No Go, Hold, Rework.

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

- File: `.gate-decision.json`
- Format: `GateDecision[]`

## Steps

### Step 0: Parse User Signal
- Detect signal from user input:
  - `Go` → gate passed, proceed
  - `No Go` → gate rejected, stop
  - `Hold` → gate deferred, revisit later
  - `Rework` → needs fixes before next review

### Step 1: Submit for Gate Decision
- Input: milestone or phase identifier (e.g. `"M1"`, `"Phase 0"`)
- Look up existing gate
  - If exists: increment `attempt`, reset `status`, clear comments
  - If new: create gate with `attempt: 1`
- Persist to `.gate-decision.json`
- Output: `GateDecision`

### Step 2: Record Decision
- Input: milestone, decision (`Go` | `No Go` | `Hold` | `Rework`), comments[], reviewer?
- Find gate (error if not found)
- Set `status`, `resolvedAt`, `comments`, `reviewer`
- Persist

### Step 3: Check Proceed Permission
- Input: milestone
- Read gates file → find gate → check `status === 'Go'`
- Output: boolean

### Step 4: Handle Go
- On `Go`: advance to next phase or milestone
- Recommend the next command (e.g., `/npd-requirement` after Phase 0)

### Step 5: Handle No Go
- On `No Go`: phase or milestone is rejected
- Log the reason in `.gate-decision.json`
- Project may need restructuring

### Step 6: Handle Hold
- On `Hold`: gate deferred
- Log the reason and revisit conditions
- Re-enter gate decision when conditions met

### Step 7: Handle Rework
- On `Rework`: needs fixes
- Log the failure reason
- Return to development fix loop (Step 7 in `opencode/workflows/phase3-develop.md`)
- Max 3 rework attempts per milestone
- After 3 reworks: escalate to No Go

## Usage

```markdown
1. Submit: `submitForGate("M1")`
2. Go: `resolveGate("M1", "Go", ["LGTM"], "reviewer")`
3. No Go: `resolveGate("M1", "No Go", ["Unreasonable architecture"])`
4. Hold: `resolveGate("M1", "Hold", ["Dependencies not ready"])`
5. Rework: `resolveGate("M1", "Rework", ["Missing exception handling"])`
6. Check: `canProceed("M1")` → `true` / `false`
```
