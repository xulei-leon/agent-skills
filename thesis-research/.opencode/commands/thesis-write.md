# /thesis-write

## Goal
Writing & formatting phase — expand the outline into full Markdown sections, run self-review and revision
loops, convert to LaTeX, and compile a PDF.

## Usage
```
/thesis-write
```

## Workflow
`.opencode/workflows/thesis-writing-phase.md`

## Constraints
- Requires research artifacts: `outline.json`, `survey_matrix.md`, `references.bib`, `innovation_ideas.md`.
  If missing, redirect to: "Research artifacts not found. Run /thesis-research first."
- Load skills in order: `thesis-write` → loop(`thesis-review` ↔ `thesis-revise`, max 3 cycles) → `thesis-latex-verify`.
- Write sections in the order specified by `outline.json.writing_order` (recommended: Methods → Experiments → Introduction → Related Work → Conclusion).
- The review↔revise loop is autonomous. Do NOT pause to ask the human.
- Each revision cycle: apply ALL critical fixes, most major fixes, and minor fixes as time permits.
- After max 3 review cycles, proceed to LaTeX compilation with the best version.
- Output artifacts: 5 `sections/*.md`, `draft.md`, `review_report.md`, `revision_log.md`, `paper.tex`, `paper.pdf`, `compile_report.md`.
- On completion, set `current_stage = "done"`.
- After completion, output: "Paper complete. paper.pdf ready."
