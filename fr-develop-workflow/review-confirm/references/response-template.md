# Response Template

Use this structure as the default output shape.

```md
# <Target> Review Confirm

**Reviewed Inputs**
- `<review-file-1>`
- `<review-file-2>`

**Review Date**
- YYYY-MM-DD

## Overall Conclusion

Explain in 1-3 short paragraphs:
- whether the review is generally sound
- whether the target artifact can be considered acceptable as-is
- which items block acceptance and which do not

## Decision Table

| No. | Severity | Type | Review Source | Original Comment Summary | Decision | Evidence | Follow-up Plan / Rejection Reason |
|---|---|---|---|---|---|---|---|
| 1 | High | Correctness | `Reviewer A C1` | One-line summary of the claim | Accept | Cite docs, code, or tests | Name the files to change and tests to add; if rejected, explain why |

## Needs Immediate Action

- List all `Accept` items and any high-priority `Partial` items.

## Can Be Deferred

- List improvements that do not block sprint acceptance.

## Final Status

State explicitly:
- whether the target should be accepted
- if not, what the minimum remaining work is
```

## Row-writing rules

- `Severity` must be one of `Critical`, `High`, `Medium`, `Low`, `Info`.
- `Type` should fit the issue, such as `Correctness`, `Security`, `Performance`, `Maintainability`, `Test`, `Documentation`, `Requirement`, `Clarity`, `Consistency`, or `Risk`.
- `Review Source` should point to the exact comment, such as `DS C1` or `Qwen W3`.
- `Original Comment Summary` should compress the claim, not copy the full review text.
- `Evidence` should prefer repository files, rules, or observable behavior.
- `Follow-up Plan / Rejection Reason` must be a full sentence, not just keywords.
