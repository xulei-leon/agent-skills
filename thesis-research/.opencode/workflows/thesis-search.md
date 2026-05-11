# Topic Search Workflow

Broad literature exploration and topic recommendation. Takes a vague research direction and produces
3-5 specific, actionable research topic candidates for the user to choose from.

## Design Philosophy

This phase embodies the auto-research loop pattern: **propose topic hypotheses → search to validate feasibility → present to user → iterate.** The user provides direction; the agent does the search labor. If the user rejects the recommendations, the agent refines and tries again — up to 3 rounds. After that, the best candidates are presented.

## Steps

### Step 1: Load Context
- Read `thesis/target.md` for `direction` and `keywords`.
- If `direction` is empty or "TBD", ask the user: "Please describe your research direction (can be vague)."
- Load the `thesis-topic-explorer` skill.

### Step 2: Broad Search (Round N, max 3)

Execute the `thesis-topic-explorer` skill's search procedure:

#### 2.1 Conceptual Space Mapping
- Parse the research direction into 3-5 conceptual dimensions.
- Each dimension represents a different angle or sub-area of the direction.
- Example: "LLM reasoning" → dimensions might be: Chain-of-Thought, planning, formal verification, multi-step reasoning, neuro-symbolic methods.

#### 2.2 Multi-Dimension Search
- For each conceptual dimension, search ArXiv and Semantic Scholar.
- Use broad queries: `{dimension} survey landscape`, `{dimension} recent advances 2024 2025`.
- Target: 30-50 papers total across all dimensions.
- Deduplicate papers that appear in multiple searches.

#### 2.3 Clustering
- Cluster the deduplicated papers into 3-5 candidate research topics.
- Each cluster should represent a distinct, viable research direction.
- A good cluster has: a clear research question, active recent publications, and identifiable gaps.

#### 2.4 Candidate Topic Generation
For each candidate topic, generate a structured recommendation:

```markdown
### Candidate {N}: {Topic Name}

**Core Problem:** {1-2 sentences — what problem does this topic address?}

**Background & State of the Art:**
{2-3 sentences on current progress. Cite 2-3 representative papers [@key].}

**Research Gap:**
{1-2 sentences — what is unsolved or under-explored?}

**Feasibility Assessment:**
- Data availability: {High/Medium/Low} — {why}
- Method maturity: {High/Medium/Low} — {why}
- Experimental requirements: {what's needed}

**Frontier Heat:**
{Recent publication trend — growing/hot/stable/cooling}

**Risk Factors:**
{Main uncertainty or challenge}

**Representative Papers:**
1. [@key1] — {1-line contribution}
2. [@key2] — {1-line contribution}
3. [@key3] — {1-line contribution}
```

Write all candidates to `thesis/topic-recommendations.md`.

### Step 3: Present to User

Use `question()` to present the recommendations:

```
question(
  header: "Select Research Topic (Round {N}/3)",
  question: "Review these candidate topics. Which one would you like to pursue?",
  options: [
    { label: "Topic 1: {name}", description: "{1-sentence core problem}" },
    { label: "Topic 2: {name}", description: "{1-sentence core problem}" },
    ...
    { label: "None — I'll provide more direction", description: "Re-run the search with updated context" }
  ]
)
```

### Step 4: Handle User Response

| User action | Response |
|-------------|----------|
| **Selected a topic** | Write the selected topic name to `thesis/target.md.selected_topic`. Update `.thesis-status.json`: `current_stage = "research"`, `stages.search.status = "completed"`. Output: "Topic selected: {name}. Next: /thesis-research". |
| **Needs more direction** | Ask: "What additional direction can you provide? (e.g., specific methods, constraints, applications)" → incorporate new info → go to Step 2 for next round. |
| **Round 3 reached** | Present final recommendations regardless. Force a selection or mark as "User must choose manually". |

### Step 5: Iteration Limit

- Max 3 rounds. Track `rounds_completed` in `.thesis-status.json`.
- After round 3, if the user still hasn't selected: present ALL recommendations with a final prompt.
- If the user provides no decision after round 3: halt, mark the stage as needing manual selection.

## Constraints
- Do NOT proceed to research phase without a confirmed topic.
- All search results and candidate topics are saved in `thesis/topic-recommendations.md`.
- The `.thesis-status.json` tracks round count and selection state.
