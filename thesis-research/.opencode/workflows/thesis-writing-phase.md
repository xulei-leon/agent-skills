# Writing & Formatting Phase Workflow

Expand the outline into full Markdown sections, run an autonomous review↔revise loop,
convert to LaTeX, and compile a publication-ready PDF.

## Design Philosophy

The review↔revise loop applies auto-research's keep/discard pattern to academic writing.
Each revision cycle is a git commit. If the review score improves, keep. If it degrades,
discard (git reset). The loop runs autonomously — no human approval needed.

## Steps

### Step 1: Verify Prerequisites
- Check that research artifacts exist: `outline.json`, `survey_matrix.md`, `references.bib`, `innovation_ideas.md`.
- If any are missing, output: "Research artifacts missing. Run /thesis-research first." → halt.
- Update `.thesis-status.json` → `current_stage = "writing"`, `stages.writing.status = "in_progress"`.

### Step 2: Write Sections (thesis-write)
- Load the `thesis-write` skill.
- Read `outline.json` for the section tree, key arguments, citation map, and writing order.
- Write sections in the order specified by `outline.json.writing_order`:
  1. Methods (Section 3)
  2. Experiments (Section 4)
  3. Introduction (Section 1)
  4. Related Work (Section 2)
  5. Conclusion (Section 5)
- For each section:
  - Parse the outline's subsections and key arguments.
  - Write each argument as a paragraph with topic sentence + citation support + logic chain.
  - Use Markdown citation syntax: `[@key]`.
  - Follow section-specific guidelines (see thesis-write skill).
- Write individual section files: `sections/1_introduction.md`, `sections/2_related_work.md`, etc.
- Assemble `draft.md` — concatenate all sections with title, abstract, and citation warnings.
- Quality gate: All 5 sections written, word counts within ±20% of plan, citations linked.
- git commit: `writing: complete first draft ({N} words, {C} citations)`

### Step 3: Review↔Revise Loop (max 3 cycles)

#### Loop Condition
Run the review↔revise loop while:
- `review_cycles < 3` AND
- The reviewer's recommendation is MINOR REVISION or MAJOR REVISION

If recommendation is ACCEPT (score ≥ 80): exit loop, proceed to LaTeX.
After 3 cycles: exit loop regardless, proceed with best version.

#### 3.1 Review (thesis-review)
- Load the `thesis-review` skill.
- Review the complete `draft.md` from an anonymous peer reviewer's perspective.
- Score 4 dimensions: logical coherence (30%), experimental adequacy (30%), academic standards (25%), language quality (15%).
- Produce `review_report.md` with: section-by-section critique, argument chain audit, citation audit,
  prioritized issues (Critical / Major / Minor), and an overall recommendation.
- git commit: `writing: review cycle {N} — score {X}/100, recommendation: {Y}`

#### 3.2 Revise (thesis-revise)
If the review recommends revision (score < 80):
- Load the `thesis-revise` skill.
- Apply fixes in priority order: Critical → Major → Minor.
- For each fix: use precise edits (the `edit` tool), not full rewrites.
- After edits: synchronize cross-section context (terminology, contribution alignment, citations).
- Rebuild `draft.md` from revised sections.
- Produce `revision_log.md` tracking all changes.
- git commit: `writing: revision cycle {N} — {C} critical, {M} major, {m} minor fixes`

#### 3.3 Keep/Discard Decision
After revision:
- Re-run review on the revised draft.
- **If score improved:** KEEP the revision commit. Continue to next cycle.
- **If score degraded:** DISCARD — `git reset --hard HEAD~2` (undo revision + re-review).
  Try a different revision strategy.
- **If score unchanged but code is cleaner:** KEEP (simplification win).

### Step 4: LaTeX Conversion & Compilation (thesis-latex-verify)
- Load the `thesis-latex-verify` skill.
- Convert each `sections/*.md` to `sections/*.tex`.
- Assemble `paper.tex` using `thesis/templates/article.tex` as the skeleton.
- Run silent compilation: `pdflatex → bibtex → pdflatex → pdflatex`.
- Capture and auto-fix compilation errors (missing citations, undefined references, math errors, etc.).
- Produce: `paper.tex`, `paper.pdf`, `compile_report.md`.
- Quality gate: `paper.pdf` exists, no fatal compilation errors.
- git commit: `writing: LaTeX compilation — {SUCCESS / WARNINGS}`

### Step 5: Writing Phase Completion
- Update `.thesis-status.json`:
  - `stages.writing.status = "completed"`
  - `stages.writing.sections_written = 5`
  - `stages.writing.review_cycles = {N}`
  - `stages.writing.review_score = {X}`
  - `stages.writing.compilation_success = {true/false}`
  - `current_stage = "done"`
  - `stages.done.status = "completed"`
- Output summary:
  ```
  ## Paper Complete

  **Title:** {title}
  **Total words:** {N}
  **Citations:** {C}
  **Final review score:** {X}/100
  **Review cycles:** {N}
  **Compilation:** {SUCCESS / WARNINGS}

  Output: paper.pdf ({KB})

  The paper is ready for submission.
  ```

## Constraints
- The review↔revise loop is autonomous. Do NOT ask the human for feedback during the loop.
- Maximum 3 review cycles. After that, proceed to LaTeX with the best version.
- If LaTeX compilation fails after auto-fix attempts, report manual fixes needed in `compile_report.md`.
- For the experiments section: write the experimental DESIGN (datasets, metrics, baselines, analysis plan).
  The agent cannot execute experiments. Flag any placeholders that need real results.
- All git commits track the writing evolution. The branch shows the full writing history.
