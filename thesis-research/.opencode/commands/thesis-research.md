# /thesis-research

## Goal
Focused research phase — for a confirmed research topic, conduct targeted deep literature survey,
generate innovation ideas, and construct a structured paper outline (IMRaD).

## Usage
```
/thesis-research                    # uses topic from target.md
/thesis-research <确定课题>          # sets topic directly, skips search phase
```

## Workflow
`.opencode/workflows/thesis-research-phase.md`

## Constraints
- Load skills in order: `thesis-survey` → `thesis-idea` → `thesis-outline`.
- This is the TARGETED survey phase (not broad exploration). Search is focused on the confirmed topic.
- Do NOT pause to ask the human whether to continue. This phase is autonomous.
- Output artifacts: `survey_matrix.md`, `references.bib`, `innovation_ideas.md`, `outline.json`.
- Quality gate: at least 15 papers surveyed, at least 3 innovation ideas, outline has all IMRaD sections.
- On completion, set `current_stage = "writing"`.
- After completion, output: "Research complete. Next: /thesis-write"
- If the topic is not confirmed (missing `selected_topic` in target.md), redirect to: "Run /thesis-search first."
