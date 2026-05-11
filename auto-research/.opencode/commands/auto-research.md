# /auto-research

## Goal
Execute autonomous multi-round research to iteratively improve a target metric. The agent proposes hypotheses,
implements changes, runs experiments, evaluates results, and decides keep/discard — all without human intervention.

## Workflow
`.opencode/workflows/auto-research-loop.md`

## Constraints
- Load the `auto-researcher` skill before starting the loop.
- Research goal and target files are defined in `research/target.md`.
- Read `research/target.md` first to understand the research goal, metric, editable/immutable files, and time budget.
- NEVER stop the experiment loop once started. Do not ask "should I continue?" or "is this a good stopping point?".
  The human might be asleep. You are autonomous. The loop runs until manually interrupted.
- All results must be logged to `research/results.tsv`. Do NOT commit this file.
- Modify only the files listed as editable in `research/target.md`. All other files are immutable.
- If `.auto-research-status.json` has `enable = false`, this command is skipped.
