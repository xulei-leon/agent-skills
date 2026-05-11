# Thesis Init Workflow

Initialize a new thesis project — interactively gather project metadata, create required files,
and prepare the environment for the thesis pipeline.

## Steps

### Step 1: Check for Existing Project
- Check if `thesis/target.md` exists in the current project.
- If it exists:
  - Use `question()` to ask: "A thesis project already exists. What would you like to do?"
  - Options: `[Continue existing project, Reset (delete and start over), Cancel]`
  - `Continue` → exit init, suggest `/thesis-continue`.
  - `Reset` → backup old files, proceed to Step 2.
  - `Cancel` → stop.

### Step 2: Create Project Directories
- Create `thesis/` and `thesis/templates/` if they don't exist.
- Create `sections/` directory (for writing phase).

### Step 3: Gather Project Metadata

Collect required information from the user. Use `question()` for each missing field.
Accept command-line argument for `direction` if provided.

**Required fields (ask in this order, skip any already known):**

| Field | target.md key | Question | Validation |
|-------|--------------|----------|------------|
| Research direction | `direction` | "What is your research direction? (Can be vague — broad area or problem space)" | Non-empty |
| Working title | `title` | "What is a working title for this paper? (Can change later)" | Non-empty |
| Author info | `author` | "Author name? (Format: Name; Email; Affiliation)" | Non-empty |
| Keywords | `keywords` | "List 5-8 keywords for literature search (comma-separated)" | 3-10 keywords |
| Target venue | `venue` | "Target conference or journal? (e.g. NeurIPS, ACL, CVPR...)" | Optional |

### Step 4: Write thesis/target.md

Write `thesis/target.md` with this structure:

```markdown
# Thesis Target — {title}

## Metadata
- **Working Title:** {title}
- **Author:** {author}
- **Keywords:** {keyword1, keyword2, ...}
- **Target Venue:** {venue or "TBD"}

## Research Direction
{direction}

## Selected Topic
> Not yet selected — will be set during /thesis-search phase.
```

### Step 5: Copy Templates
- Copy `thesis/templates/article.tex`, `thesis/templates/paper-structure.md`, and `thesis/templates/review-checklist.md` from the thesis-research installation source into the project's `thesis/templates/` directory.

### Step 6: Initialize .thesis-status.json

Write `.thesis-status.json`:

```json
{
  "thesis": {
    "enable": true,
    "current_stage": "search",
    "stages": {
      "search": { "status": "pending", "rounds_completed": 0, "candidates_generated": 0 },
      "research": { "status": "pending", "papers_surveyed": 0, "ideas_generated": 0, "outline_complete": false },
      "writing": { "status": "pending", "sections_written": 0, "review_cycles": 0, "review_score": 0, "compilation_success": false },
      "done": { "status": "pending" }
    },
    "project": {
      "title": "",
      "author": "",
      "direction": "",
      "keywords": [],
      "selected_topic": "",
      "venue": ""
    }
  }
}
```

- Fill `project` fields from gathered metadata.

### Step 7: Output Summary

Print a summary of what was initialized:
```
## Thesis Project Initialized

**Title:** {title}
**Author:** {author}
**Direction:** {direction}
**Keywords:** {keywords}
**Venue:** {venue}

Ready for topic selection.

**Next:** /thesis-search
```

## Constraints
- Do NOT proceed to search automatically. Init only initializes.
- If any required field is empty after questioning, prompt again.
- Max 3 attempts to get a valid answer per field, then use a reasonable default or mark as "TBD".
