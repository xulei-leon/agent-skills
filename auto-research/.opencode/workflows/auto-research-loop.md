# Autonomous Research Loop Workflow

The AI agent conducts autonomous multi-round research: propose a hypothesis, implement it, run an experiment,
evaluate the result, and decide whether to keep or discard the change. This loops indefinitely until the human interrupts.

## Design Philosophy

This workflow is modeled after the same principles that make `karpathy/autoresearch` effective:

1. **Constrained scope** — a single target file to edit, a single metric to optimize, a fixed time budget.
   This makes experiments directly comparable and keeps the agent from getting lost in rabbit holes.
2. **Keep/discard via git** — clean rollback on failure, clean diffs on success.
3. **Autonomous mindset** — the agent never pauses to ask permission. It thinks, acts, and iterates.
4. **Simplicity criterion** — small gains from ugly code are not worth it. Removing code at equal performance IS a win.

---

## Stage 1: Setup

Before starting the experiment loop, establish the environment:

### 1.1 Read the Research Target
- Read `research/target.md` in full.
- Understand: the goal, the target metric (name, extraction command, direction), which files are editable vs. immutable,
  the time budget per experiment, and any hard constraints (VRAM, dependencies, etc.).

### 1.2 Verify Environment
- Confirm required dependencies are installed. if not, tell the human to install them.
- Confirm required hardware (GPU, memory, disk space) is available.
- Verify data or other prerequisites exist. If missing, tell the human to run setup.

### 1.3 Create the Experiment Branch
- Agree on a run tag based on today's date (e.g. `may11`).
- The branch must be named `auto-research/<tag>`. It must NOT already exist — this is a fresh run.
- Create the branch from the current working state: `git checkout -b auto-research/<tag>`

### 1.4 Establish the Baseline
- Run the experiment **without any modifications** to record the starting metric.
- This is the baseline. Every future experiment is compared against the best result so far.

### 1.5 Initialize Tracking
- Create `research/results.tsv` with the header row (tab-separated, NOT comma-separated).
- Header columns: `commit` `metric` `memory_gb` `status` `description`
- Record the baseline as the first row.
- Do NOT commit `results.tsv` — leave it untracked so the git branch stays clean.

### 1.6 Update Status
- Write `.auto-research-status.json` with baseline and start timestamp.

---

## Stage 2: The Experiment Loop

Once setup is complete, begin the loop. **This loop runs FOREVER until the human interrupts you.**

### LOOP FOREVER:

#### 2.1 Observe Current State
- Check which branch/commit you're on.
- Review `research/results.tsv` — what experiments have been tried? What worked? What didn't?
- Read the current state of the editable target file.

#### 2.2 Propose a Hypothesis
Generate an experimental idea. Read the code, the results history, and think about what might improve the metric.

**Idea generation strategies** (cycle through these, don't fixate on one):

| Phase | Focus Area | Examples |
|-------|-----------|---------|
| Hyperparameter tuning | Learning rate, batch size, decay schedules, warmup | Adjust LR by 2x, try cosine schedule |
| Architecture tweaks | Depth, width, activation functions, normalization | Add/remove layers, swap GELU for SiLU |
| Optimizer changes | Optimizer type, momentum, weight decay | Try different optimizer, change beta values |
| Training dynamics | Gradient clipping, mixed precision, data ordering | Change clip threshold, shuffle strategy |
| Structural simplification | Remove unnecessary code, consolidate paths | Delete dead branches, merge duplicate logic |
| Radical changes | Major architectural shifts, novel combinations | Replace a module entirely, try a completely different approach |

**Heuristics**:
- Start conservative. Early experiments should be the most obvious / highest-probability ideas.
- As good ideas run out, increase risk. Try more aggressive, creative, or radical changes.
- If a previous experiment was a "near miss" (almost better), try combining it with other good ideas.
- Re-read `research/target.md` periodically for fresh perspective.
- When truly stuck, step back and think about what fundamental assumption might be wrong.

#### 2.3 Implement the Change
- **Modify ONLY the editable file(s)** listed in `research/target.md`.
- Make the change **surgical** — touch only what's needed for the hypothesis.
- Do not clean up unrelated code. Do not refactor things that aren't broken.
- Match the existing code style precisely.
- If the hypothesis requires changes to multiple files, double-check `research/target.md` — immutable files are OFF LIMITS.

#### 2.4 Commit the Change
- `git add` only the modified editable file(s).
- `git commit -m "exp: <brief description of the hypothesis>"`
- Keep commit messages short and descriptive (under 80 chars).

#### 2.5 Run the Experiment
Execute the experiment command as defined in `research/target.md`. Follow these rules:

- **Redirect output**: always redirect stdout and stderr to `run.log`. e.g. `command > run.log 2>&1`
- **Do NOT use `tee`** or let output flood your context window.
- **Time budget**: The experiment must complete within the fixed time budget specified in `research/target.md`.
  - The time budget is a soft target — the experiment should normally finish within it.
  - If the process exceeds 2× the time budget, something is wrong — **kill it** and treat as a failure (discard + revert).
  - If the experiment completes normally (within or near the budget), proceed to evaluation.

#### 2.6 Evaluate the Result
Extract the target metric from the run log using the extraction command defined in `research/target.md`.

- **Success**: the extraction command returns a single valid numeric value.
- **Invalid**: extraction returns empty, multiple values, or non-numeric output. Treat as a crash — discard & log.
- **Crash**: the log contains a Python traceback (runtime error).
  - For trivial fixes (typos, missing imports): fix and re-run (max 1 attempt — don't waste time).
  - For fundamental breaks (the idea is incompatible): abandon, log as `crash`, discard.

#### 2.7 Log the Result
Append a row to `research/results.tsv`:
```
<commit_hash7>  <metric_value>  <memory_in_gb>  <status>  <description>
```

- `status` is one of: `keep`, `discard`, or `crash`
- For crashes, use `0.0` for both metric and memory.
- Use tabs (`\t`) as separators, NOT commas.

**IMPORTANT**: Do NOT commit `results.tsv` to git. Leave it untracked.

#### 2.8 Decide: Keep or Discard
Compare the new metric against the current best. Know the metric direction from `research/target.md` (lower or higher is better), then apply this decision table:

| Metric Δ | Complexity Δ | Decision |
|----------|-------------|----------|
| **Better** (beyond noise floor) | Equal or simpler | **KEEP** — advance the branch |
| **Better** (beyond noise floor) | Noticeably more complex | **KEEP cautiously** — weigh the trade-off |
| **Better** (beyond noise floor) | Significantly uglier/hackier | **DISCARD** — not worth it |
| **Equal** (within noise floor) | Simpler (fewer lines, cleaner) | **KEEP** — simplification IS a victory |
| **Equal** (within noise floor) | Equal | **DISCARD** — no benefit, adds risk |
| **Equal** (within noise floor) | More complex | **DISCARD** |
| **Worse** | Any | **DISCARD** — `git reset --hard HEAD~1` |
| **Crash** (not fixable) | — | **DISCARD** — `git reset --hard HEAD~1`, log as `crash` |

**Simplicity criterion**: A 0.1% improvement that adds 30 lines of hacky code is probably not worth it. A 0% improvement that removes 50 lines is definitely worth it. When in doubt, prefer simplicity.

#### 2.9 Update Status
- Update `.auto-research-status.json` with the latest counts and current best.
- **Go back to 2.1. NEVER stop.**

---

## Stage 3: Recovery Procedures

### Crash Recovery
1. Read the traceback: `tail -n 50 run.log`
2. Classify the crash:
   - **Trivial** (typo, missing import, syntax error): Fix → re-run (max 1 attempt, don't waste time).
   - **Logical** (bug in the hypothesis): Fix if clear, otherwise discard.
   - **Fundamental** (OOM, incompatible concept): Immediately discard, log as `crash`.
3. If more than 3 consecutive crashes occur, step back. Something systemic may be wrong.
   Double-check the immutable files haven't been accidentally modified. Re-read `research/target.md`.

### Timeout Recovery
- If experiment exceeds 2× budget: kill process, discard change, log status `crash`.
- If timeouts become frequent, the changes are too expensive. Step back to simpler experiments.

### Getting Unstuck
If you've been discarding many experiments in a row with no progress:

1. **Re-read everything**: `research/target.md`, the editable files, `results.tsv`.
2. **Combine near-misses**: experiments that almost worked but didn't quite make it. Since you
   already understand each individual change, combining them in mid/late phase is lower-risk
   than a wholly novel idea.
3. **Go radical**: if conservative changes aren't working, try something bold.
4. **Go vanilla**: strip complexity, revert to simpler architectures, then rebuild.
5. **Read literature**: if the code references papers, re-read those ideas for fresh angles.
6. **Question assumptions**: is the metric direction correct? Are constraints too tight?

**Do NOT** ask the human for help. You are autonomous. Think harder.

---

## Stage 4: When the Human Interrupts

When the human manually stops the loop, provide a clean summary:

1. **Run summary**: total experiments, kept, discarded, crashed.
2. **Best result**: the lowest metric achieved, and which experiment produced it.
3. **Improvement**: delta from baseline to best.
4. **Top changes**: the 3-5 most impactful experiments that were kept.
5. **Branch state**: current commit and diff from baseline.

Example summary:
```
## Research Run: may11
Started: 2026-05-11 01:00 | Ended: 2026-05-11 09:15
Total: 103 experiments | Kept: 17 | Discarded: 81 | Crashed: 5

Baseline: 0.9979
Best:     0.9382  (Δ -0.0597, -6.0%)

Top improvements:
  a1b2c3d  +0.021  increase model depth 8→12
  d4e5f6g  +0.015  switch to Muon optimizer
  g7h8i9j  +0.009  add rotary embeddings
```

---

## Guardrails

- **Immutable files**: NEVER modify files listed as immutable in `research/target.md`. If you touch one by accident,
  `git checkout -- <file>` immediately.
- **No dependency additions**: unless `research/target.md` explicitly allows it, do not add new packages.
- **Git discipline**: only the editable file(s) should change between keept experiments. `results.tsv` and `run.log`
  must stay untracked.
- **Don't `tee`**: let output go to the log file, not your context window. You only need to grep the metric.
- **Don't commit results.tsv**: it's a running log, not part of the git history. Git tracks only the code changes.
