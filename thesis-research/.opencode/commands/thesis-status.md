# /thesis-status

## Goal
Display the current pipeline status and project summary. Read-only — no modifications.

## Usage
```
/thesis-status
```

## Output Format

Read `.thesis-status.json` and `thesis/target.md`. Print a human-readable summary:

```
## Thesis Project Status

**Title:** {title}
**Author:** {author}
**Research Direction:** {direction}
**Selected Topic:** {selected_topic or "Not yet selected"}
**Target Venue:** {venue}

### Pipeline Progress

| Stage | Status | Details |
|-------|--------|---------|
| Search (topic selection) | {status} | {rounds completed} rounds, {N} candidates |
| Research (survey + outline) | {status} | {papers} papers, {ideas} ideas, outline: {yes/no} |
| Writing (draft + review + LaTeX) | {status} | {sections} sections, {cycles} review cycles, score: {score} |
| Done | {status} | paper.pdf: {yes/no} |

### Current Stage: {current_stage}

Next: {suggested next command based on current_stage}
```

## Constraints
- Read-only. Do not modify any files.
- If `.thesis-status.json` is missing, output: "No thesis project found. Run /thesis-init first."
