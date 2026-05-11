# /thesis-init

## Goal
Create a new thesis project — gather user input interactively, initialize project files, and prepare the environment for academic paper writing.

## Usage
```
/thesis-init <研究方向>
```
- `<研究方向>` — vague research direction (optional on command line; will be asked if missing)

## Workflow
`.opencode/workflows/thesis-init.md`

## Constraints
- Read `thesis/target.md` to detect existing projects before overwriting.
- Use `question()` to interactively gather missing fields: title, author, direction, keywords (5-8), venue.
- Do NOT ask for fields already present in target.md or provided via command argument.
- Create `thesis/target.md` with all gathered metadata.
- Copy templates from `thesis-research/thesis/templates/` into the project `thesis/templates/` directory.
- Initialize `.thesis-status.json` with `current_stage = "search"`.
- After completion, output: "Project initialized. Next: /thesis-search"
- Load the `thesis-topic-explorer` skill reference (but do NOT execute search yet).
