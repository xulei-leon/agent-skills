# /thesis-search

## Goal
Topic selection phase — progressive funnel from vague research direction to a confirmed paper topic
through five stages: broad dimension search → first recommendation → deep analysis → iterative
refinement → final selection.

## Usage
```
/thesis-search
```
No arguments — reads the research direction from `thesis/target.md`.

## Workflow
`.opencode/workflows/thesis-search.md`

## Constraints
- Load the `thesis-topic-explorer` skill before starting.
- Read `thesis/target.md` for the research `direction` and `keywords`.
- All search results accumulate in `thesis/search/paper-pool.md` — never discarded, never re-searched.
- The search is a progressive funnel: each stage narrows scope but deepens analysis.
- Five stages with independent search depths:
  1. `broad` — shallow, wide, discover dimensions
  2. `cluster` — medium, supplementary re-clustering
  3. `deep` — deep targeted search for shortlisted topics
  4. `refine` — feedback-driven incremental search (repeatable)
  5. `final` — confirm and advance to research phase
- Any stage can exit directly to final selection if the user finds the right topic.
- From Stage 3 onward, the user may select a single topic to finalize.
- No hard iteration limit — natural convergence via paper pool exhaustion.
- On confirmation, write the selected topic to `thesis/target.md.selected_topic`,
  set `.thesis-status.json.current_stage = "research"`.
- After completion, output: "Topic selected. Next: /thesis-research"
