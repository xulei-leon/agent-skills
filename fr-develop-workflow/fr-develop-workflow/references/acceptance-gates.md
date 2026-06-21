# Acceptance Gates

Use these checks before advancing phases.

## FR Gate

The FR document is ready for document review when:

- `FR_DIR`, `FR_BACKLOG_DIR`, `FR_DONE_DIR`, `SPRINT_DIR`, `REVIEW_DIR`, and `VERIFICATION_COMMANDS` have been resolved from project instructions or explicitly documented fallback.
- The file is under resolved `FR_DIR` or `FR_BACKLOG_DIR`.
- The filename follows `FR-<id>-<slug>.md`.
- Required header fields from project instructions or the fallback FR template are present: `FR-ID`, `标题`, `所属阶段`, `开发顺序`, `优先级`, `前置依赖`, `涉及包`, `是否属于原型阶段`, `来源类型`, `原始 SRS 章节`.
- The body includes at least `目标`, `需求描述`, `高层要求`, `验收要点`, and `备注`.
- Background, scope, failure/degradation, non-goals, and minimum verification are included when relevant to the FR.
- Requirements are concrete, testable, and aligned with the active project's requirement source of truth.
- Module, package, runtime-data, dependency, and ownership boundaries are aligned with the active project's instructions and design documents.
- If prompts, templates, schemas, or external integrations are affected, the relevant project-specific reference documents are checked.
- Blocking open questions are resolved or explicitly accepted by the user.

## Sprint Gate

The Sprint document is ready for document review when:

- The file is under resolved `SPRINT_DIR`.
- The filename follows `sprint-m<major>-<nn>.md`.
- It links to source FR document(s) under resolved `FR_DIR`.
- It uses this section pattern: `Sprint 目标`, `前置依赖`, `纳入范围`, `暂不纳入范围`, `工作范围`, `验收标准`, `验证要求`, `实施顺序`, `风险控制`, `交付结论`.
- Sprint scope maps to FR goals, requirements, and acceptance points.
- Work packages are concrete enough for TDD implementation and include test requirements.
- File, module, data, interface, prompt, runtime, and configuration impacts are identified when knowable.
- Verification uses commands declared by the active project instructions. If the project does not declare verification commands, inferred commands are listed with the reason they are sufficient for the touched areas.
- Rollout, recovery, fallback, or compatibility behavior is covered when relevant.
- Blocking risks or questions are resolved or explicitly accepted by the user.

## Document Review Confirmation Gate

Document changes can proceed when:

- All review reports are present and non-empty.
- `review-confirm` has produced a confirmation document.
- Every actionable review comment has an `Accept`, `Partial`, or `Reject` decision.
- Accepted and partially accepted comments have concrete follow-up actions.

## Implementation Gate

Code implementation can start when:

- The Sprint document has passed document review confirmation.
- Accepted and partially accepted document-review changes are applied or explicitly deferred.
- The confirmed Sprint target is clear in the conversation, Sprint document, or an explicitly requested workflow state file.
- TDD coverage exists or the Sprint establishes the minimum executable test skeleton before implementation.

## Code Review Confirmation Gate

Code changes from review can proceed when:

- All code review reports are present and non-empty.
- `review-confirm` has produced a code review confirmation document.
- Every actionable code review comment has an `Accept`, `Partial`, or `Reject` decision.
- Accepted and partially accepted comments have concrete follow-up actions.

## Final Completion Gate

The workflow is complete when:

- All non-skipped phases are marked done.
- Accepted review-confirm actions are applied or explicitly deferred.
- Verification commands or checks have been run and recorded.
- Remaining risks or blockers are documented.
- Completed FR and Sprint documents are moved to resolved `FR_DONE_DIR` and `SPRINT_DONE_DIR` only when the work is accepted as done.
