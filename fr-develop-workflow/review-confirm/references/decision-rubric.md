# Decision Rubric

Use this checklist for each review comment.

## 1. Verify the claim

Check whether the comment is supported by:

- target acceptance criteria or documented scope
- requirement, spec, or design document
- architecture, interface, or policy docs
- AGENTS.md repository rules
- current code or test behavior

If the reviewer gives no evidence, verify it manually before deciding.

## 2. Judge the right level

Ask:

- Is the problem real?
- Is the reviewer's severity correct?
- Is the proposed fix the smallest correct fix?
- Does the fix stay inside the current review target and agreed scope?

Use `Partial` when the problem is real but the requested fix is too broad, wrongly scoped, or attached to the wrong layer.

## 3. Prefer repository source of truth

Use this priority order:

1. `AGENTS.md`
2. relevant requirement / acceptance docs
3. relevant design, interface, or policy docs
4. current package boundaries, code, and tests
5. reviewer preference

If a review comment conflicts with the first three items, reject it and cite the conflict.

## 4. Typical acceptance patterns

Accept when the comment identifies:

- broken acceptance criteria
- architecture boundary violations
- prompt hard-coding
- runtime data written outside `runtime/`
- missing validation, unsafe path handling, uncaught exceptions, or real test gaps

## 5. Typical partial-accept patterns

Partially accept when:

- the issue exists but the reviewer overstates severity
- the proposed fix crosses package boundaries unnecessarily
- the current target needs a minimal correction, not a larger redesign
- the comment mixes one valid point with one invalid conclusion

## 6. Typical rejection patterns

Reject when:

- the comment relies on V1 behavior that V2 explicitly simplified away
- the code already satisfies the requirement through another layer
- the requested change belongs to a later requirement, later milestone, or separate change set
- the reviewer misread the document, API contract, or boundary rule

## 7. Required row quality

For every row:

- summarize the original comment in one line
- make the decision explicit
- cite the key evidence
- give a concrete next action or rejection reason

Bad:

`Reject, not taking this change now.`

Good:

`Reject; the approved interface contract fixes the current output shape, so this suggestion conflicts with the accepted boundary for this change.`
