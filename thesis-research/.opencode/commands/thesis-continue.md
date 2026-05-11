# /thesis-continue

## Goal
Resume a thesis pipeline from the last known stage. Reads `.thesis-status.json` to determine
the current stage, then routes to the appropriate workflow.

## Usage
```
/thesis-continue
```

## Routing Logic

Read `.thesis-status.json` → `current_stage`:

| `current_stage` | Action |
|----------------|--------|
| `search` | Load `thesis-topic-explorer` skill, execute `.opencode/workflows/thesis-search.md` |
| `research` | Load `thesis-survey` → `thesis-idea` → `thesis-outline` skills, execute `.opencode/workflows/thesis-research-phase.md` |
| `writing` | Load `thesis-write` → `thesis-review` → `thesis-revise` → `thesis-latex-verify` skills, execute `.opencode/workflows/thesis-writing-phase.md` |
| `done` | Output: "Paper is already complete. Run /thesis-status for details." |
| missing / unknown | Output: "No project found. Run /thesis-init first." |

## Constraints
- Do NOT re-run completed stages. Resume from the checkpoint.
- Check that required artifacts for the current stage still exist. If missing, back up one stage.
- Preserve all existing artifacts. Do not overwrite unless explicitly re-executing a stage.
