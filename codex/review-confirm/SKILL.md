---
name: review-confirm
description: Use when reviewing third-party feedback on a document, spec, implementation, code change, or review file and producing a point-by-point confirmation. Trigger this skill when Codex needs to judge each review comment against repository evidence, decide accept/partial/reject, propose concrete follow-up actions for accepted items, and explain why rejected items are not adopted.
---

# Review Confirm

Use this skill to turn one or more review artifacts into a single review-confirmation document with explicit decisions for every actionable comment.

The output must answer every comment in a Markdown table. Do not stop at a summary. Do not merge multiple comments into one vague conclusion unless they are exact duplicates.

## Required Inputs

Read these artifacts before writing the confirmation:

1. The target artifact under review: document, spec, code diff, commit, PR notes, or implementation files.
2. The review document, comment thread, or feedback file that contains the claims to judge.
3. The relevant source-of-truth requirements, design docs, interfaces, or policies named by the review comments.
4. Any directly referenced code, test, runtime artifact, or observable behavior needed to verify the claim.

If the review comments touch prompt placement, architecture boundaries, workflow direction, or runtime data placement, re-check `AGENTS.md` and the V2 docs before deciding.

## Workflow

1. Identify the target artifact and all input review files or comment sources.
2. Extract every actionable review comment.
3. Remove exact duplicates, but keep separate rows when two reviewers reach the same conclusion with different reasoning.
4. Judge each comment against repository evidence, not reviewer confidence.
5. Write one confirmation document under `docs/4-Reviews/`, matching the `review-start` output location. Use this naming pattern:
   - `<target-id>-review-confirm.md`
6. Include:
   - reviewed input files
   - overall conclusion
   - one row per review comment
   - concrete follow-up plan for accepted or partially accepted items
   - explicit rejection reason for rejected items

## Decision Rules

Use the rubric in `references/decision-rubric.md`.

Default decisions:

- `Accept`: the issue is real, in scope, and should be changed now.
- `Partial`: the reviewer found a real problem, but the proposed severity, fix, or scope is too broad or partly incorrect.
- `Reject`: the claim conflicts with source-of-truth docs, misreads the artifact, duplicates an already-satisfied constraint, or pushes work outside the current scope without enough justification.

Prefer `Partial` when the diagnosis is directionally right but the requested change is oversized, cross-boundary, or not required for current acceptance.

## Output Contract

Use the table template in `references/response-template.md`.

Each row must answer all of these:

- the severity level of the confirmed issue or comment
- the issue type
- which review comment is being answered
- what the decision is
- why that decision is correct
- what to change now if the comment is accepted
- why it is not adopted if rejected

Use these severity values: `Critical`, `High`, `Medium`, `Low`, `Info`.

Use issue types that fit the finding, such as `Correctness`, `Security`, `Performance`, `Maintainability`, `Test`, `Documentation`, `Requirement`, `Clarity`, `Consistency`, `Risk`.

Never leave an accepted row without a concrete follow-up plan.
Never leave a rejected row with only "not in scope"; explain the governing evidence.

## Guardrails

- Do not accept comments only because they sound severe.
- Do not reject comments only because they are inconvenient.
- Do not treat V1 implementation details as binding unless V2 docs still adopt them.
- Do not expand a review confirmation into a full redesign plan unless the review proves the current target cannot be accepted without it.
- Do not output only prose paragraphs; the review response must contain a complete Markdown table of decisions with severity and issue type columns.
- Do not hide uncertainty. If evidence is incomplete, say what was checked and what remains unverified.
