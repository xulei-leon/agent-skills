---
name: thesis-topic-explorer
description: >
  Broad literature exploration and research topic recommendation. Takes a vague research direction,
  maps it to conceptual dimensions, searches ArXiv and Semantic Scholar, clusters findings into
  3-5 candidate research topics with feasibility assessments, and presents structured recommendations
  for user selection. This is the search/discovery skill — not targeted survey.
license: MIT
---

# thesis-topic-explorer — Topic Exploration & Recommendation

## Role
Research Topic Explorer — discovers and recommends viable research topics from a vague direction.
You search broadly across multiple conceptual dimensions, cluster findings, and present actionable
candidates for the user to choose from.

## Trigger
Loaded during the `/thesis-search` phase. Receives a vague research direction and keyword list
from `thesis/target.md`.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `direction` | `thesis/target.md` | Vague research direction (e.g. "LLM reasoning", "video generation") |
| `keywords` | `thesis/target.md` | 5-8 keywords for initial search seeding |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `thesis/topic-recommendations.md` | Markdown | Structured topic candidates with feasibility analysis |
| `thesis/topic-search-log.md` | Markdown | Search traces: queries executed, papers found, deduplication log |

---

## Phase 1: Conceptual Space Mapping

Decompose the research direction into 3-5 **conceptual dimensions**. Each dimension is a
distinct angle, sub-area, or paradigm within the broad direction.

**Method**: Read the direction statement. Think about:
- What are the main sub-problems people work on in this area?
- What different approaches or paradigms exist?
- What applications or domains intersect this area?

**Example**:
- Direction: "LLM reasoning"
- Dimensions:
  1. Chain-of-Thought / step-by-step reasoning
  2. Planning & multi-step problem solving
  3. Formal verification of reasoning
  4. Neuro-symbolic reasoning methods
  5. Reasoning evaluation & benchmarks

**Output**: Write a "Conceptual Space Map" section in `thesis/topic-search-log.md`.

---

## Phase 2: Multi-Dimension Broad Search

For each conceptual dimension, search both ArXiv and Semantic Scholar.

### ArXiv Search
```
websearch_web_search_exa(
  query="arxiv.org {dimension} survey OR landscape OR recent advances",
  numResults=10
)
```

### Semantic Scholar Search
```
webfetch(
  url="https://api.semanticscholar.org/graph/v1/paper/search?query={dimension}&limit=10&fields=title,authors,year,abstract,externalIds,citationCount,publicationTypes",
  format="text"
)
```

### Search Strategy per Dimension
1. **Broad**: `{dimension} survey landscape review`
2. **Recent**: `{dimension} 2024 2025`
3. **Method-focused**: `{dimension} method approach technique`

### Collect & Deduplicate
- Target: 30-50 unique papers across all dimensions.
- Deduplicate by ArXiv ID and title similarity (>80% fuzzy match).
- Record all search queries and result counts in `thesis/topic-search-log.md`.

---

## Phase 3: Clustering into Candidate Topics

Analyze the deduplicated papers. Cluster them into 3-5 distinct candidate research topics.

### What Makes a Good Candidate Topic

| Criterion | Check |
|-----------|-------|
| **Has a clear research question** | The cluster centers on a specific, articulable problem |
| **Is active** | Recent publications (2023-2025) show ongoing work |
| **Has identifiable gaps** | Limitations or open problems are visible in the literature |
| **Is scope-appropriate** | Not too broad (an entire field) or too narrow (one paper's tweak) |
| **Is feasible** | Data, methods, and compute appear accessible |

### Clustering Method
1. Group papers by shared problem statement, method category, or application domain.
2. Identify the "center" of each cluster — the most cited or most representative paper.
3. For each cluster, extract:
   - Common research question across papers
   - Dominant approaches used
   - Recurring limitations cited by the papers themselves
   - Trend direction (growing? stable? declining?)

---

## Phase 4: Generate Topic Recommendations

For each candidate topic, write a structured recommendation:

```markdown
### Candidate {N}: {Topic Name}

**Core Problem:**
{1-2 sentences — the specific research question this topic addresses}

**Background & State of the Art:**
{2-3 sentences summarizing current progress. Cite 2-3 representative papers.}

**Research Gap:**
{What is unsolved? What limitations do existing papers acknowledge?}

**Feasibility Assessment:**

| Factor | Rating | Rationale |
|--------|--------|-----------|
| Data availability | High/Med/Low | {why} |
| Method maturity | High/Med/Low | {why} |
| Experimental requirements | {description} | — |
| Compute/resources needed | {description} | — |

**Frontier Heat:**
{Recent publication trend — growing rapidly / active / stable / cooling}

**Risk Factors:**
{1-2 sentences on the main uncertainties or challenges}

**Representative Papers (Top 5):**
1. [Author et al. (Year)] — {1-line contribution}. *{N} citations.*
2. ...
```

---

## Phase 5: Comparative Summary

After all candidates, write a comparison table:

```markdown
## Comparative Summary

| Criterion | Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|-----------|---------|---------|---------|---------|---------|
| Novelty potential | ★★★★ | ★★★ | ★★★★★ | ★★ | ★★★ |
| Feasibility | ★★★ | ★★★★★ | ★★ | ★★★★ | ★★★ |
| Publication prospects | ★★★★ | ★★★ | ★★★★★ | ★★ | ★★★ |
| Alignment with direction | ★★★★★ | ★★★★ | ★★★ | ★★★ | ★★ |
| **Overall** | **16/20** | **15/20** | **15/20** | **11/20** | **11/20** |

## Top Recommendations
1. **{Topic N}** — {one-line reason}
2. **{Topic M}** — {one-line reason}
3. **{Topic K}** — {one-line reason}
```

---

## Quality Gate

Before returning to the orchestrator, verify:
- [ ] Conceptual space decomposed into 3-5 dimensions (written in search log)
- [ ] Searches executed against BOTH ArXiv and Semantic Scholar (logged)
- [ ] 30-50 papers found and deduplicated (logged)
- [ ] Papers clustered into 3-5 distinct candidate topics
- [ ] Each candidate has: core problem, background, gap, feasibility, risk, top-5 papers
- [ ] Comparative summary table completed
- [ ] `thesis/topic-recommendations.md` written
- [ ] `thesis/topic-search-log.md` written

## Return Format

```
Status: completed
Artifacts produced:
  - thesis/topic-recommendations.md ({N} candidates)
  - thesis/topic-search-log.md ({M} papers searched)
Candidates: {list of topic names}
```
