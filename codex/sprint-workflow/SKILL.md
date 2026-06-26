---
name: sprint-workflow
description: "Use when a user asks for a Sprint lifecycle, FR develop workflow, document-to-code delivery, multi-sprint sequential development, or review-confirm gated implementation across configurable project document paths."
---

# Sprint Workflow

## Overview

Use this skill to coordinate one or more Sprint delivery loops from FR requirements to reviewed implementation. This is an orchestration skill: reuse `review-start` for independent reviews and `review-confirm` for point-by-point review decisions.

## Required Flow

For a single Sprint, run the complete FR develop workflow below.

Follow these phases in order unless the user explicitly asks to skip or resume at a named phase:

1. Write or update the FR document.
2. Write or update the Sprint document.
3. Invoke `review-start` for document review on the FR/Sprint target and require it to write review report files under `REVIEW_DIR`.
4. Invoke `review-confirm` using the target document and all review reports, and require it to write a review-confirm document under `REVIEW_DIR`.
5. Modify the FR/Sprint document according to accepted and partially accepted findings.
6. Implement code according to the confirmed Sprint document.
7. Invoke `review-start` for code review on the implementation files, diff, or PR-style change set and require it to write code review report files under `REVIEW_DIR`.
8. Invoke `review-confirm` using the implementation target and all code review reports, and require it to write a code-review-confirm document under `REVIEW_DIR`.
9. Modify code according to accepted and partially accepted findings.
10. Run relevant verification and update workflow state.
11. If all previous phases succeeded, stage only the workflow-related changes and create a git commit with message `feat: complete <sprint-id> code and change base on reviews`. Resolve `<sprint-id>` from the target Sprint document name, such as `sprint-m4-05`; if no Sprint id can be resolved, use `sprint-xx-xx`.

Do not start code implementation until document review confirmation is complete and accepted document changes are applied, unless the user explicitly overrides this gate.

Do not modify code based directly on code review reports before `review-confirm` has judged the review comments, unless the user explicitly overrides this gate.

## Multiple Sprint Development

When the user asks to develop multiple Sprints, process them strictly in sequence. For each Sprint, run the full FR develop workflow from document authoring through review confirmation, implementation, code review confirmation, verification, and commit.

Do not develop multiple Sprints in parallel. Do not start a later Sprint until the current Sprint has completed every required gate or the user has explicitly skipped a gate.

If any Sprint stops for any reason, including missing inputs, failed review integration, failed verification, unresolved blockers, or user cancellation, stop the whole multi-Sprint run. Record the stopped Sprint, phase, reason, and remaining unstarted Sprint targets in workflow state and the final response.

## Path Configuration

Resolve project paths before creating or moving documents. Use the first available source in this order:

1. Explicit user instruction or skill invocation parameters.
2. Repository instructions such as `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, or equivalent.
3. Existing repository layout.
4. The fallback paths below.

Use these variable names in reasoning and status updates:

```text
FR_DIR
FR_BACKLOG_DIR
FR_DONE_DIR
DESIGN_DIR
SPRINT_DIR
SPRINT_DONE_DIR
REVIEW_DIR
REVIEW_DONE_DIR
WORKFLOW_STATE_PATH
VERIFICATION_COMMANDS
```

Fallback values:

```text
FR_DIR=docs/1-Requirement
FR_BACKLOG_DIR=${FR_DIR}/backlog
FR_DONE_DIR=${FR_DIR}/Done
DESIGN_DIR=docs/2-Design
SPRINT_DIR=docs/3-Plan
SPRINT_DONE_DIR=${SPRINT_DIR}/Done
REVIEW_DIR=docs/4-Reviews
REVIEW_DONE_DIR=${REVIEW_DIR}/Done
WORKFLOW_STATE_PATH=<unset unless explicitly requested>
VERIFICATION_COMMANDS=<read from project instructions; infer only if absent>
```

Default document targets after resolving variables:

```text
FR documents: ${FR_DIR}/FR-<id>-<slug>.md
Backlog FR documents: ${FR_BACKLOG_DIR}/FR-<id>-<slug>.md
Completed FR documents: ${FR_DONE_DIR}/FR-<id>-<slug>.md
Sprint documents: ${SPRINT_DIR}/sprint-m<major>-<nn>.md
Completed Sprint documents: ${SPRINT_DONE_DIR}/sprint-m<major>-<nn>.md
Review reports and confirmation documents: ${REVIEW_DIR}/
```

Use `REVIEW_DIR` for all review reports and confirmation documents to stay compatible with `review-start` and `review-confirm`. Review report files and review-confirm files are required workflow outputs, not optional notes.

## State Handling

This workflow does not require a persistent state file. Do not create one by default.

Track workflow state in the active FR/Sprint documents, review-confirm documents, and final response. If the user explicitly requests a persistent workflow state file, use `WORKFLOW_STATE_PATH` from project instructions or ask for a location. If no location is provided, use the fallback shown in `references/workflow-state-template.md`.

Record:

- current phase
- target FR document
- target Sprint document
- review report paths
- review confirmation paths
- implementation target
- verification commands and results
- open blockers or explicit user overrides

## Goal Mode Integration

Goal mode is optional. Do not require it for this workflow.

Use Codex goal mode only when the user explicitly asks to run the Sprint workflow as a goal, long-running objective, or auto-continuing task. The goal objective should cover the full Sprint delivery lifecycle, not an individual phase.

Do not use goal state as a substitute for workflow records. Continue to record phase state, review outputs, confirmation decisions, verification results, blockers, and commit status in the active FR/Sprint documents, review-confirm documents, and final response.

Mark the goal complete only after all Sprint Workflow completion criteria are satisfied, including verification and the final commit unless the user explicitly skipped that gate.

Mark the goal blocked only when progress is genuinely impossible without user input or an external state change, and after the platform's blocked-condition threshold is satisfied. Ordinary review findings, failed tests, missing reports, or implementation issues should be handled through the normal workflow gates first.

## Document Authoring

When creating a new FR document, use `references/fr-template.md`.

When creating a new Sprint document, use `references/sprint-template.md`.

Before drafting, record the resolved path variables and `VERIFICATION_COMMANDS` source. If any value is inferred from repository layout rather than project instructions, state the fallback explicitly.

Before writing or structurally changing FR/Sprint documents, read the active project's source-of-truth instructions and design documents, if they exist. Typical files include:

- repository agent instructions such as `AGENTS.md`
- requirement index or SRS documents under `FR_DIR`
- architecture or design documents under `DESIGN_DIR`
- baseline or development plan documents under `SPRINT_DIR`

Before sending a document to review, check it against `references/acceptance-gates.md`.

## Review Integration

For document review:

- Invoke `review-start` on the FR document, Sprint document, or combined target requested by the user.
- Require `review-start` to write one or more review report files to `REVIEW_DIR`, using the active project naming convention or the fallback pattern `<source-file-name>-review-by-<reviewer>.md`.
- Then invoke `review-confirm` with the target document plus every generated document review report.
- Require `review-confirm` to write a confirmation document to `REVIEW_DIR`, using the active project naming convention or the fallback pattern `<source-file-name>-review-confirm.md`.
- Apply only accepted and partially accepted changes from the confirmation document.

For code review:

- Invoke `review-start` with code review intent on the implementation files, diff, or change set.
- Require `review-start` to write one or more code review report files to `REVIEW_DIR`, using the active project naming convention or the fallback pattern `<source-file-name>-code-review-by-<reviewer>.md`.
- Then invoke `review-confirm` with the implementation target plus every generated code review report.
- Require `review-confirm` to write a code review confirmation document to `REVIEW_DIR`, using the active project naming convention or the fallback pattern `<source-file-name>-code-review-confirm.md`.
- Apply only accepted and partially accepted changes from the confirmation document.

If review commands fail, reports are missing, or confirmation documents are missing, stop the affected phase, record the failure in workflow state, and report the blocker. Do not proceed to implementation or review-driven code changes without the required files.

## Git Commit Gate

Create the final git commit only after every prior gate has succeeded:

- Document review reports exist in `REVIEW_DIR`.
- Document review-confirm exists in `REVIEW_DIR` and accepted/partial actions are applied or explicitly deferred.
- Code implementation matches the confirmed Sprint document.
- Code review reports exist in `REVIEW_DIR`.
- Code-review-confirm exists in `REVIEW_DIR` and accepted/partial actions are applied or explicitly deferred.
- `VERIFICATION_COMMANDS` and required targeted checks have passed or any failure is explicitly accepted by the user.

Before committing, inspect the working tree. Stage only files changed for this FR/Sprint workflow. Do not stage unrelated user changes. Use this commit message template:

```text
feat: complete <sprint-id> code and change base on reviews
```

Replace `<sprint-id>` with the target Sprint document basename without `.md`, for example `sprint-m4-05`. If the Sprint id cannot be resolved, use the fallback `sprint-xx-xx`.

## Implementation Rules

Implement strictly from the confirmed Sprint document. If code work reveals missing or contradictory requirements, update the Sprint document first, then repeat the document review gate when the change is material.

Prefer the repository's existing architecture, helpers, tests, and conventions. Keep unrelated refactors out of the workflow unless required by the confirmed Sprint scope.

Respect the active project's architecture boundaries, source-of-truth instructions, runtime-data rules, and language/runtime choices. Do not infer project-specific constraints from this skill.

## Completion Criteria

The workflow is complete only when:

- FR and Sprint documents pass the document confirmation gate.
- Accepted document review items are applied or explicitly deferred.
- Code implementation matches the confirmed Sprint document.
- Code review confirmation is complete.
- Accepted code review items are applied or explicitly deferred.
- Relevant tests or verification commands have been run and recorded in workflow state.
- A git commit has been created with message `feat: complete <sprint-id> code and change base on reviews`, unless the user explicitly skipped the commit gate.

## References

- `references/fr-template.md`: use when drafting or filling an FR document.
- `references/sprint-template.md`: use when drafting or filling a Sprint document.
- `references/workflow-state-template.md`: use only if the user explicitly asks for a persistent workflow state file.
- `references/acceptance-gates.md`: use before review gates and before final completion.


