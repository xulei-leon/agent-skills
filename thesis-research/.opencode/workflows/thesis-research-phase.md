# Focused Research Phase Workflow

For a confirmed research topic, conduct a targeted deep literature survey, generate innovation ideas,
and build a structured IMRaD paper outline. This phase is autonomous — no human interruption.

## Design Philosophy

This phase applies the auto-research keep/discard loop to academic idea generation. Survey papers are
classified by relevance. Innovation ideas are evaluated and filtered. The best ideas survive into
the outline. Every step is tracked via git commits, enabling rollback of weak ideas.

## Steps

### Step 1: Verify Prerequisites
- Read `thesis/target.md`. Confirm `selected_topic` is not empty.
- If empty, output: "No topic selected. Run /thesis-search first." → halt.
- Update `.thesis-status.json` → `current_stage = "research"`, `stages.research.status = "in_progress"`.

### Step 2: Targeted Literature Survey (thesis-survey)
- Load the `thesis-survey` skill.
- Execute a FOCUSED survey — unlike the broad search in topic selection, this search targets
  the confirmed topic specifically.
- Search both ArXiv and Semantic Scholar with precise queries: `"{topic}" method approach technique`.
- Target: 15-25 papers (fewer but deeper than the topic exploration phase).
- Produce:
  - `survey_matrix.md` — structured literature review matrix with categories, gaps, limitations.
  - `references.bib` — BibTeX entries for all surveyed papers.
- Each paper entry must include: core contribution, background context, stated limitations.
- Organize papers into 3-5 thematic categories.
- Quality gate: ≥15 papers after deduplication, categories complete, cross-category observations written.
- git commit: `research: complete literature survey ({N} papers, {K} categories)`

### Step 3: Innovation Idea Generation (thesis-idea)
- Load the `thesis-idea` skill.
- Extract gaps from `survey_matrix.md` (stated limitations, recurring limitations, open problems).
- If the user provided an initial research conception in `target.md`, analyze it.
- Generate 3-5 innovation ideas. Each idea must:
  - Map to a specific gap (GAP-ID)
  - Have a clear approach direction
  - Be distinguishable from existing work
  - Include a validation strategy
  - Have a risk assessment
- **Auto-research keep/discard**: Evaluate each idea against feasibility and novelty criteria.
  - Strong ideas (high novelty + feasible) → KEEP, mark as recommended.
  - Weak ideas (incremental, infeasible) → DISCARD, but log in the ideas document.
- Produce `innovation_ideas.md` with comparative evaluation table.
- Quality gate: ≥3 innovation ideas generated, gap inventory from survey, comparative evaluation complete.
- git commit: `research: generate {N} innovation ideas`

### Step 4: Paper Outline Construction (thesis-outline)
- Load the `thesis-outline` skill.
- Based on the selected innovation idea(s) from Step 3:
  - Build a complete IMRaD outline with: Introduction, Related Work, Methods, Experiments, Conclusion.
  - Each section has subsections, key arguments (with citation support), and planned word counts.
  - Define the argument chain — the logical flow connecting all sections.
  - Create a citation map — which citations support which sections.
  - Plan figures and tables.
  - Specify the writing order (recommended: Methods → Experiments → Introduction → Related Work → Conclusion).
- Produce `outline.json` — valid, parseable JSON following the IMRaD schema.
- Quality gate: All 5 top-level sections present, argument chain complete, citation map populated,
  writing order specified, valid JSON.
- git commit: `research: complete paper outline ({N} sections, {M} arguments)`

### Step 5: Research Phase Completion
- Update `.thesis-status.json`:
  - `stages.research.status = "completed"`
  - `stages.research.papers_surveyed = {N}`
  - `stages.research.ideas_generated = {M}`
  - `stages.research.outline_complete = true`
  - `current_stage = "writing"`
- Output summary:
  ```
  ## Research Phase Complete

  **Papers surveyed:** {N} in {K} categories
  **Innovation ideas:** {M} generated, {R} recommended
  **Outline:** {S} sections, {A} arguments, {C} citations planned

  Artifacts:
    - survey_matrix.md
    - references.bib
    - innovation_ideas.md
    - outline.json

  **Next:** /thesis-write
  ```

## Constraints
- This phase is autonomous. Do NOT ask the user "should I continue?" or "is this a good direction?"
- Modify only files in the thesis project. Do not modify templates.
- Track all changes with git commits at each sub-step.
- If a step fails (e.g., too few papers found), expand search scope or notify user.
