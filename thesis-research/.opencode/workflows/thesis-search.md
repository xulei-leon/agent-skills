# Topic Search Workflow

Progressive funnel from vague direction to confirmed research topic. Five stages move from broad
exploration to deep analysis, with a shared paper pool accumulating knowledge across all stages.

## Design Philosophy

**Progressive deepening, not repeated resets.** Each stage narrows scope but deepens analysis.
Papers discovered in Stage 1 are reused in Stage 2, 3, and 4 — never discarded. The user guides
the funnel at each step, choosing which branches to explore further.

**Any stage can exit.** If the user finds the right topic in Stage 2, they can select it immediately.
No forced march through all 5 stages.

**Simplicity-guided.** Each successive stage costs more (more searches, more tokens). Don't go deeper
than the user's interest signals warrant.

---

## Paper Pool

All searched papers live in `thesis/search/paper-pool.md` (Markdown format). This pool grows across
stages — papers are appended, never removed. Each paper entry tracks:

```markdown
### {cite_key}
- **Title:** {title}
- **Authors:** {authors}
- **Year:** {year}
- **Source:** {arxiv | semantic_scholar}
- **Depth:** {shallow | medium | deep}
- **Dimensions:** [{dim_id}, ...]
- **Topics:** [{topic_id}, ...]
- **Relevance:** {★ to ★★★★★}
- **Key Contribution:** {1 sentence}
- **Limitations:** {1 sentence}
```

**Depth markers:**
- `shallow` — only abstract read. Suitable for dimension scoping.
- `medium` — abstract + intro/conclusion skimmed. Suitable for topic clustering.
- `deep` — full paper analyzed. Suitable for gap/feasibility assessment.

---

## State Tracking

`.thesis-status.json` → `stages.search` now tracks:

```json
{
  "search": {
    "status": "pending",
    "current_search_stage": 1,
    "dimensions_searched": [],
    "interesting_dimensions": [],
    "paper_pool_size": 0,
    "topics_shortlisted": [],
    "deep_dive_completed": false,
    "final_topic_selected": null
  }
}
```

- `current_search_stage`: 1-5, which stage we're in.
- `dimensions_searched`: list of dimension IDs already searched (prevents re-searching).
- `interesting_dimensions`: which dimensions the user marked as interesting in Stage 1.
- `paper_pool_size`: total papers accumulated.
- `topics_shortlisted`: topic IDs selected for deep dive.
- `deep_dive_completed`: whether Stage 3 has been executed at least once.
- `final_topic_selected`: the confirmed topic name (set in Stage 5).

---

## Stage Flow

```
Stage 1 (广度搜索)     → user marks interesting dimensions
                         FAST EXIT: "I want this one" → Stage 5
                         
Stage 2 (首次推荐)     → supplementary search + cluster → ranked shortlist
                         user picks 2-3 topics for deep dive
                         FAST EXIT: "I want this one" → Stage 5
                         
Stage 3 (深度搜索)     → deep search 2-3 topics → detailed analysis
                         user picks 1-2 topics + feedback
                         user can select 1 topic → Stage 5

Stage 4 (重复深度搜索) → refine with user feedback → updated analysis
                         user picks 1-2 topics + feedback (repeatable)
                         user can select 1 topic → Stage 5
                         
Stage 5 (最终选定)     → confirm → write target.md
```

---

## Stage 1: 广度搜索 (Broad Search)

**Purpose:** Cast the widest possible net. Discover all sub-directions within the vague research area.

### Steps

#### 1.1 Conceptual Space Mapping
- Read `thesis/target.md` for `direction` and `keywords`.
- Load the `thesis-topic-explorer` skill.
- Decompose the direction into 5-7 conceptual dimensions.
- Each dimension = a distinct angle, sub-area, or paradigm.
- Write dimensions to `thesis/search/dimensions.md`.

#### 1.2 Search New Dimensions
- For each dimension NOT already in `dimensions_searched`:
  - Execute `thesis-topic-explorer` in `broad` mode.
  - 1-2 queries per dimension, per source (ArXiv + Semantic Scholar).
  - Read abstracts only → mark depth as `shallow`.
  - Append papers to `thesis/search/paper-pool.md`.
  - Add dimension to `dimensions_searched`.

#### 1.3 Present Dimension Summary
Present a concise table to the user:

```markdown
## Conceptual Dimensions — {direction}

| # | Dimension | Papers Found | Activity Level | Sample Paper |
|---|-----------|-------------|----------------|--------------|
| 1 | {name}    | {N}         | {hot/active/stable} | "{title}" ({year}) |
| 2 | ...       | ...         | ...            | ...          |
```

#### 1.4 User Interaction

Use `question()` (multiple-select):

```
question(
  header: "Which dimensions look interesting? (Stage 1 — Broad Search)",
  question: "Select all dimensions you'd like to explore further. You can also provide a note.",
  options: [
    { label: "Dim 1: {name} ({N} papers)", description: "{sample paper summary}" },
    { label: "Dim 2: {name} ({N} papers)", description: "{sample paper summary}" },
    ...,
    { label: "None — I want to add new directions", description: "Provide additional search terms or angles" }
  ],
  multiple: true
)
```

#### 1.5 Handle Response

| User action | Response |
|-------------|----------|
| Selected dimension(s) | Record as `interesting_dimensions`. Proceed to Stage 2. |
| "None — new directions" | Ask user for new directions/angles. Add them as new dimensions. Return to 1.2 to search the new ones. |
| (No response after 3 prompts) | Proceed to Stage 2 with all dimensions as "interesting". |

**After response:**
- If `interesting_dimensions` has at least 1 entry → update `.thesis-status.json` → `current_search_stage = 2`.
- Update `paper_pool_size` in status.

---

## Stage 2: 首次推荐 (First Recommendation)

**Purpose:** Consolidate papers from the user's interesting dimensions, cluster into candidate research topics,
and present a ranked shortlist.

### Steps

#### 2.1 Extract Pool Papers for Interesting Dimensions
- Read `thesis/search/paper-pool.md`.
- Filter to papers that belong to any `interesting_dimension`.
- If a dimension has very few papers (< 5), the topic cluster may be thin.

#### 2.2 Supplementary Search (as needed)
- For dimensions with too few papers, or where the clustering feels incomplete:
  - Execute `thesis-topic-explorer` in `cluster` mode.
  - Search specifically for papers linking or bridging the interesting dimensions.
  - Append to paper pool, mark depth as `medium`.

#### 2.3 Re-Cluster into Candidate Topics
- Take ALL papers from the filtered pool (not just per-dimension).
- Re-cluster them into 2-4 candidate research topics.
- Topics should cross dimensions where natural — a good topic often spans multiple angles.

#### 2.4 Generate Ranked Shortlist
Produce `thesis/search/candidates.md` (short-form):

```markdown
## Candidate Research Topics — Round 1

| # | Topic | Core Question | Novelty | Feasibility | Confidence | Best Paper |
|---|-------|--------------|---------|-------------|------------|------------|
| 1 | {name} | {1-line question} | ★★★★ | ★★★ | medium (8 deep, 12 medium, 5 shallow) | "{title}" |
| 2 | {name} | {1-line question} | ★★★ | ★★★★★ | high (15 deep, 10 medium) | "{title}" |
| 3 | ... | ... | ... | ... | ... | ... |

**Confidence:** How much of the analysis is based on deep-read vs shallow-read papers.
```

#### 2.5 User Interaction

Use `question()` (multiple-select):

```
question(
  header: "First Recommendation — Pick 2-3 topics to deep-dive (Stage 2)",
  question: "Which topics look most promising for deeper investigation?",
  options: [
    { label: "Topic 1: {name}", description: "{core question} | Novelty: ★★★★, Feasibility: ★★★" },
    { label: "Topic 2: {name}", description: "{core question} | Novelty: ★★★, Feasibility: ★★★★★" },
    ...,
    { label: "Topic N — This is the one!", description: "I'm confident in this topic. Skip deep dive." }
  ],
  multiple: true
)
```

#### 2.6 Handle Response

| User action | Response |
|-------------|----------|
| "This is the one!" with a specific topic selected | Jump to Stage 5 with that topic. |
| Selected 2-3 topics | Record as `topics_shortlisted`. Proceed to Stage 3. |
| "Don't like any" | Ask: "What's missing or what direction to adjust?" → go back to Stage 1 (keep pool). |

---

## Stage 3: 深度搜索 (Deep Search)

**Purpose:** For the 2-3 shortlisted topics, do deep, targeted searches and produce complete analyses.
From this stage onward, the user can select a SINGLE topic as final.

### Steps

#### 3.1 Deep Search per Topic
For each shortlisted topic:
- Execute `thesis-topic-explorer` in `deep` mode.
- 3-4 queries per topic, per source.
- Read ~10-15 papers per topic fully.
- Mark depth as `deep` in paper pool.
- Append to `thesis/search/paper-pool.md`.

#### 3.2 Generate Deep Analysis
For each shortlisted topic, produce a full analysis in `thesis/search/deep-analysis.md`:

```markdown
## Deep Analysis: {Topic Name}

### Core Problem
{2-3 sentences — precise problem statement}

### Literature Overview
{2-3 paragraphs covering the state of the art. Cite specific papers [@key].}

### Research Gap
{What is specifically unsolved? Why hasn't it been solved?}

### Feasibility Assessment

| Factor | Rating | Evidence |
|--------|--------|----------|
| Data availability | High | {which datasets exist} |
| Method maturity | Medium | {what methods are close but need adaptation} |
| Experimental requirements | {description} | {estimated compute/data needs} |
| Novelty risk | Low/Med/High | {risk of being scooped or found incremental} |

### Innovation Angle
{How would your contribution be different from existing work?}

### Representative Papers (Top 5, deep-read)
| # | Paper | Core Insight | Limitation |
|---|-------|-------------|------------|
| 1 | [@key] ({year}) | {insight} | {limitation} |
| 2 | ... | ... | ... |
```

#### 3.3 User Interaction (Two Steps)

**Step 3a — Topic selection:**

Use `question()` (multiple-select, with single-select option):

```
question(
  header: "Deep Analysis Complete — Select topics (Stage 3a)",
  question: "After the deep analysis, which topic(s) still look promising? You can select 1 to finalize.",
  options: [
    { label: "Topic 1: {name}", description: "Gap: {1-line gap} | Feasibility: High" },
    { label: "Topic 2: {name}", description: "Gap: {1-line gap} | Feasibility: Medium" },
    ...
  ],
  multiple: true
)
```

**Step 3b — Feedback (always asked after 3a):**

```
question(
  header: "Any feedback? (Stage 3b)",
  question: "What additional thoughts do you have? (e.g., methods to consider, constraints, concerns). Or skip.",
  options: [
    { label: "Skip — proceed", description: "No additional feedback" }
  ],
  custom: true
)
```

#### 3.4 Handle Response

| 3a + 3b result | Response |
|----------------|----------|
| Selected 1 topic, no feedback | Jump to Stage 5 — finalize. |
| Selected 1 topic + feedback | Record feedback. Jump to Stage 5 with notes for research phase. |
| Selected 2 topics (with or without feedback) | Record feedback. Proceed to Stage 4 with the 2 topics. |
| "Don't like any" | Ask: "What's missing?" → go back to Stage 1 or Stage 2. |

---

## Stage 4: 重复深度搜索 (Repeat Deep Search)

**Purpose:** Refine with user feedback, re-search, update analysis. Repeatable — no hard limit.
User can select a SINGLE topic as final at any iteration.

### Steps

#### 4.1 Parse User Feedback
- From Stage 3 or previous Stage 4 iteration: read user's feedback text.
- Extract: keywords, methods, constraints, concerns.
- Derive new search directions from the feedback.
- Example: "candidate 2 seems promising but evaluation metrics are unclear" →
  search for "{topic} evaluation benchmark metric".

#### 4.2 Refine Search
- Execute `thesis-topic-explorer` in `refine` mode.
- Search specifically for the directions derived from feedback.
- 2-3 queries per topic.
- Append papers to pool, mark depth as `deep`.

#### 4.3 Update Deep Analysis
- Update `thesis/search/deep-analysis.md` for the selected topics.
- Incorporate new papers.
- Adjust feasibility, novelty, risk ratings.

#### 4.4 User Interaction (Two Steps)

**Step 4a — Topic selection:**

```
question(
  header: "Refined Analysis — Select topics (Stage 4a, iteration {N})",
  question: "After refinement, which topic(s) still look promising? Select 1 to finalize.",
  options: [
    { label: "Topic 1: {name}", description: "Updated: {key change from last iteration}" },
    { label: "Topic 2: {name}", description: "Updated: {key change}" },
    { label: "None — none of these work", description: "Go back to earlier stage or provide new direction" }
  ],
  multiple: true
)
```

**Step 4b — Feedback:**

```
question(
  header: "Additional feedback? (Stage 4b)",
  question: "Any new directions, constraints, or thoughts? Or skip.",
  custom: true
)
```

#### 4.5 Handle Response

| 4a + 4b result | Response |
|----------------|----------|
| Selected 1 topic | Jump to Stage 5 — finalize. |
| Selected 2 topics + new feedback | Go to 4.1 (parse new feedback, refine, iterate). |
| Selected 2 topics, no new feedback | If same 2 as last iteration → suggest moving to Stage 5. If different → refine. |
| "None of these work" | Ask: "What new direction?" → go back to Stage 1 with user input. |

#### 4.6 Loop Termination
- Natural convergence: user selects 1 topic → Stage 5.
- Stagnation: same 2 topics, no new feedback, ≥2 iterations → gently suggest: "It may be time to pick one. These are the best options we've found."
- No hard limit on iterations. But each iteration should add NEW papers or NEW analysis — don't loop without progress.

---

## Stage 5: 最终选定 (Final Selection)

**Purpose:** Confirm the selected topic and advance the pipeline.

### Steps

#### 5.1 Confirm Topic
- If the topic came from Stage 3/4/any fast-exit: confirm it's the user's final choice.
- If this is Stage 5 firing organically: present the best candidate.

#### 5.2 Write to target.md
- Write the confirmed topic name to `thesis/target.md` → `Selected Topic`.

#### 5.3 Update Status
```json
{
  "stages.search.status": "completed",
  "stages.search.final_topic_selected": "{topic name}",
  "current_stage": "research"
}
```

#### 5.4 Output Summary
```
## Topic Selection Complete

**Selected Topic:** {name}
**Dimensions explored:** {N}
**Papers in pool:** {M}
**Deep analyses performed:** {K}

**Next:** /thesis-research
```

---

## Constraints
- **Paper pool is cumulative.** Never delete papers. Search results from any stage remain available for re-clustering.
- **Never re-search a dimension already in `dimensions_searched`** unless the user explicitly adds a new angle within that dimension.
- Each stage's search depth matches its purpose: shallow for scoping, deep for final analysis.
- All search queries are logged in `thesis/search/paper-pool.md` (appended as search log section).
- If `.thesis-status.json` has `current_search_stage` set, resume from that stage (for `/thesis-continue`).
