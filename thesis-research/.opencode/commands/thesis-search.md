# /thesis-search

## Goal
Topic selection phase — execute broad literature search, cluster findings into candidate research topics,
present recommendations to the user, and iterate until a satisfactory topic is selected.

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
- The search is broad and exploratory — cover multiple conceptual dimensions, not just one keyword.
- Cluster results into 3-5 candidate topics. Each topic recommendation must include: name, core problem,
  background status, research gap, feasibility assessment, and risk.
- Present recommendations via `question()` for user selection.
- If the user selects a topic: write it to `thesis/target.md.selected_topic`, set `current_stage = "research"`.
- If the user is unsatisfied and provides additional direction: re-run the search with updated context.
- Maximum 3 search iterations. After 3 rounds, present final recommendations regardless.
- After completion, output: "Topic selected. Next: /thesis-research"
