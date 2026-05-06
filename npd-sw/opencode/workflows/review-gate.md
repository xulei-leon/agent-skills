# Review Gate Workflow

Track milestone/phase review submissions, approvals, rejections, and attempt counts.

## Data Types

```typescript
interface ReviewGate {
  milestone: string;
  status: 'pending' | 'submitted' | 'passed' | 'failed';
  submittedAt: string;
  resolvedAt?: string;
  reviewer?: string;
  comments: string[];
  attempt: number;
}
```

## Storage

- File: `.review-gates.json`
- Format: `ReviewGate[]`

## Steps

### Step 1: Submit for Review
- Input: milestone identifier (e.g. `"M1"`)
- Look up existing gate for milestone
  - If exists: increment `attempt`, reset `status` to `submitted`, clear comments
  - If new: create gate with `status: submitted`, `attempt: 1`
- Persist to `.review-gates.json`
- Output: `ReviewGate`

### Step 2: Resolve Review
- Input: milestone, resolution (`passed` | `failed`), comments[], reviewer?
- Find gate by milestone (error if not found)
- Set `status`, `resolvedAt`, `comments`, `reviewer`
- Persist

### Step 3: Check Proceed Permission
- Input: milestone
- Read gates file → find gate → check `status === 'passed'`
- Output: boolean

### Step 4: Enforce Attempt Limit
- Max 3 failed attempts per milestone
- On 3rd failure: warn user, log unresolved issues, proceed anyway

## Usage

```markdown
1. Submit: `submitForReview("M1")`
2. Pass: `resolveReview("M1", "passed", ["LGTM"], "reviewer-name")`
3. Fail: `resolveReview("M1", "failed", ["缺少异常处理"])`
4. Check: `canProceedToNextMilestone("M1")` → `true` / `false`
```
