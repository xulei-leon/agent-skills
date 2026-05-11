# Research Target

> **To the human**: Fill in this file to define what you want the AI agent to research and optimize.
> This is the research equivalent of a "spec" — it tells the agent what to work on, what not to touch,
> and how to measure success. The more precise you are, the better the agent performs.
>
> **To the agent**: Read this file in full before starting. It defines your entire research scope.
> Everything not listed as editable is **IMMUTABLE**. Do not touch it.

---

## Goal

<!-- One-line description of what we're trying to achieve. Be specific. -->
<!-- Example: "Minimize validation bits-per-byte for a GPT model on short-story text data." -->

TODO: describe the research goal

---

## Target Metric

<!-- The single metric the agent will optimize. -->
<!-- Example: val_bpb (lower is better), extracted via `grep "^val_bpb:" run.log` -->

- **Name**: TODO
- **Extraction command**: TODO (e.g. `grep "^metric_name:" run.log`)
- **Direction**: TODO (choose one: `lower is better` or `higher is better`)
- **Noise floor**: TODO (minimum meaningful difference — changes smaller than this are noise)

---

## Time Budget

<!-- Every experiment runs for exactly this much wall-clock time, no matter the platform. -->

- **Experiment time**: TODO seconds (wall clock, excluding startup overhead)
- **Timeout kill at**: TODO seconds (2× experiment time is a reasonable default)

---

## Editable File(s)

<!-- The only file(s) the agent is allowed to modify. Keep this list small (1-3 files). -->
<!-- One file is ideal. Multiple files only when experiments naturally span them. -->

- `TODO` — description of what this file contains and what the agent can change

---

## Immutable Files

<!-- These files the agent can READ but must NOT modify. -->

- `research/target.md` — this file (the research spec is the foundation)
- `TODO` — other files the agent should not touch

---

## Experiment Command

<!-- The exact command to run one experiment. Output must go to run.log. -->

```bash
TODO > run.log 2>&1
```

---

## Constraints

<!-- Hard limits and rules the agent must respect. -->

- **Dependencies**: TODO (e.g. "No new packages beyond what's in pyproject.toml")
- **Memory limit**: TODO (e.g. "48000 MB VRAM" — soft or hard limit?)
- **Simplicity preference**: TODO (e.g. "Prefer simpler code at equal metric performance")

---

## Results Tracking

<!-- The agent logs results to research/results.tsv with these columns (tab-separated): -->
<!-- commit | metric | memory_gb | status | description -->
<!-- Do not change the column format. The agent depends on it. -->

## State Control

<!-- .auto-research-status.json tracks the research run state. -->
<!-- Set "enable" to false to disable the auto-research loop and skip the command. -->
<!-- The agent updates automated fields (branch, counts, metric values) during the run. -->
