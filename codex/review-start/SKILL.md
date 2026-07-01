---
name: review-start
description: Use when the user asks to review documents, markdown, specs, plans, source code, diffs, or implementation files with opencode or Claude Code, especially requests phrased as review start, document review, docs review, code review, or output review reports.
---

# Review Start

## Overview

Run two independent reviews for the target file and save both review reports under `docs/4-Reviews/`: one with `opencode` and one with Claude Code. If the Claude Code command errors or times out before completing, retry that same review with `opencode` using model `volcengine/doubao-seed-2-1-pro-260628`.

Use these exact command shapes:

```bash
opencode -m "<model>" --agent build run "<prompt>"
claude -p --model <model> --permission-mode auto "<prompt>"
```

Claude Code fallback command shape:

```bash
opencode -m "volcengine/doubao-seed-2-1-pro-260628" --agent build run "<prompt>"
```

## Timeout Policy

Treat `opencode` and Claude Code review commands as long-running LLM orchestration commands, not short local commands.

- Use a long command timeout when the execution environment supports it: at least 10 minutes for ordinary document reviews, and 20-30 minutes for large code reviews, commit reviews, or repository-wide diffs.
- If a command times out at the shell/tool layer, do not immediately assume the review failed. First check whether the expected report file now exists and is non-empty.
- If the report file exists and is non-empty after a timeout, treat that reviewer as completed and report that the command timed out from the caller's perspective but produced the required report.
- If the report file is still missing or empty, poll for it before falling back: check the expected report path every 30 seconds for up to 10 minutes, or up to 20 minutes for large code reviews, commit reviews, or repository-wide diffs.
- During polling, treat the review as completed as soon as the expected report file exists and is non-empty.
- Only run the Claude fallback after confirming the Claude-side report is still missing or empty.

## Review Type

Choose the review type from the user's wording:

| User intent | Report suffix | Models |
|---|---|---|
| Document review, docs review, spec review, markdown review, plan review | `review` | `deepseek/deepseek-v4-pro` via `opencode` (report name: `deepseek-v4-pro`), `ark-code-latest` via Claude Code with `volcengine/doubao-seed-2-1-pro-260628` via `opencode` fallback |
| Code review, implementation review, source review, diff review, PR-style review | `code-review` | `deepseek/deepseek-v4-pro` via `opencode`, `ark-code-latest` via Claude Code with `volcengine/doubao-seed-2-1-pro-260628` via `opencode` fallback |

If the user does not clearly specify document review or code review, infer from the file type and content. Treat source files, patches, and diffs as code review. Treat `.md`, `.txt`, `.docx`, specs, plans, and prose-heavy artifacts as document review.

## Output Rules

Always create the output directory relative to the active repository or workspace root:

```text
docs/4-Reviews/
```

For each model, write one report file:

```text
<original-file-stem>-<suffix>-by-<model-name>.md
```

Normalize `<model-name>` by replacing `/` with `-`.

Examples:

```text
docs/4-Reviews/design-review-by-deepseek-v4-pro.md
docs/4-Reviews/design-review-by-ark-code-latest.md
docs/4-Reviews/api-code-review-by-deepseek-v4-pro.md
docs/4-Reviews/api-code-review-by-ark-code-latest.md
```

## Workflow

1. Identify the target file path and review type.
2. Create `docs/4-Reviews/` if it does not exist.
3. Compute the output path for each model from the original file stem, suffix, and normalized model name.
4. Run `opencode` for `deepseek/deepseek-v4-pro` when doing document review, or `deepseek/deepseek-v4-pro` when doing code review.
5. Run Claude Code for `ark-code-latest`.
6. If the Claude Code command returns a non-zero exit code, prints an error indicating it did not complete, or times out before finishing, apply the Timeout Policy checks before retrying the same prompt with running `opencode` for `volcengine/doubao-seed-2-1-pro-260628`.
7. Keep the Claude-side output path unchanged when using the fallback: write to the `...-by-ark-code-latest.md` report path unless the user explicitly asks to name reports by the actual fallback model.
8. Ensure each review writes only its own report file.
9. After both commands finish, verify both report files exist and are non-empty.

## Prompt Template

Use a direct prompt that includes the target file, review type, output path, and strict write requirement:

```text
Review the file: <target-file>

Review type: <document review|code review>

Write the complete review report to:
<output-file>

Requirements:
- Create parent directories if needed.
- Write only this report file.
- Use Markdown.
- Output review findings as a Markdown table.
- The findings table must include these columns: Severity, Type, Location, Issue, Evidence, Recommendation.
- Use Severity values: Critical, High, Medium, Low, Info.
- Use Type values that fit the finding, such as Correctness, Security, Performance, Maintainability, Test, Documentation, Requirement, Clarity, Consistency, Risk.
- Include concrete findings with file references when applicable.
- Prioritize correctness, risks, missing evidence, unclear logic, and actionable improvements.
```

## Command Examples

Document review:

```bash
opencode -m "deepseek/deepseek-v4-pro" --agent build run "Review the file: docs/spec.md

Review type: document review

Write the complete review report to:
docs/4-Reviews/spec-review-by-deepseek-v4-pro.md

Requirements:
- Create parent directories if needed.
- Write only this report file.
- Use Markdown.
- Output review findings as a Markdown table.
- The findings table must include these columns: Severity, Type, Location, Issue, Evidence, Recommendation.
- Use Severity values: Critical, High, Medium, Low, Info.
- Use Type values that fit the finding, such as Correctness, Security, Performance, Maintainability, Test, Documentation, Requirement, Clarity, Consistency, Risk.
- Include concrete findings with file references when applicable.
- Prioritize correctness, risks, missing evidence, unclear logic, and actionable improvements."
```

```bash
claude -p --model ark-code-latest --permission-mode auto "Review the file: docs/spec.md

Review type: document review

Write the complete review report to:
docs/4-Reviews/spec-review-by-ark-code-latest.md

Requirements:
- Create parent directories if needed.
- Write only this report file.
- Use Markdown.
- Output review findings as a Markdown table.
- The findings table must include these columns: Severity, Type, Location, Issue, Evidence, Recommendation.
- Use Severity values: Critical, High, Medium, Low, Info.
- Use Type values that fit the finding, such as Correctness, Security, Performance, Maintainability, Test, Documentation, Requirement, Clarity, Consistency, Risk.
- Include concrete findings with file references when applicable.
- Prioritize correctness, risks, missing evidence, unclear logic, and actionable improvements."
```

Code review:

```bash
opencode -m "deepseek/deepseek-v4-pro" --agent build run "Review the file: src/app.ts

Review type: code review

Write the complete review report to:
docs/4-Reviews/app-code-review-by-deepseek-v4-pro.md

Requirements:
- Create parent directories if needed.
- Write only this report file.
- Use Markdown.
- Output review findings as a Markdown table.
- The findings table must include these columns: Severity, Type, Location, Issue, Evidence, Recommendation.
- Use Severity values: Critical, High, Medium, Low, Info.
- Use Type values that fit the finding, such as Correctness, Security, Performance, Maintainability, Test, Documentation, Requirement, Clarity, Consistency, Risk.
- Include concrete findings with file references when applicable.
- Prioritize correctness, risks, missing tests, regressions, security issues, and actionable improvements."
```

```bash
claude -p --model ark-code-latest --permission-mode auto "Review the file: src/app.ts

Review type: code review

Write the complete review report to:
docs/4-Reviews/app-code-review-by-ark-code-latest.md

Requirements:
- Create parent directories if needed.
- Write only this report file.
- Use Markdown.
- Output review findings as a Markdown table.
- The findings table must include these columns: Severity, Type, Location, Issue, Evidence, Recommendation.
- Use Severity values: Critical, High, Medium, Low, Info.
- Use Type values that fit the finding, such as Correctness, Security, Performance, Maintainability, Test, Documentation, Requirement, Clarity, Consistency, Risk.
- Include concrete findings with file references when applicable.
- Prioritize correctness, risks, missing tests, regressions, security issues, and actionable improvements."
```

## Completion

Report the two generated file paths to the user. If Claude Code failed but the `volcengine/doubao-seed-2-1-pro-260628` via `opencode` fallback succeeded, state that the second report was generated by fallback while preserving the configured output path. If either review ultimately fails or a report file is missing or empty, state which model path failed and include the relevant command output.
