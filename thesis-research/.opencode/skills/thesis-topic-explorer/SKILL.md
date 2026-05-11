---
name: thesis-topic-explorer
description: >
  Progressive literature search and topic recommendation. Supports four search modes (broad, cluster,
  deep, refine) that correspond to the thesis-search workflow stages. Maintains a Markdown paper pool
  across all searches, tracking depth (shallow/medium/deep) for quality transparency.
license: MIT
---

# thesis-topic-explorer — Topic Exploration & Recommendation

## Role
Research Topic Explorer that supports progressive deepening. You have four search modes,
each called at a different stage of the topic search workflow. All searches write to a shared
paper pool (`thesis/search/paper-pool.md`), which accumulates knowledge across stages.

## Modes Overview

| Mode | Trigger (Stage) | Search Depth | Queries per Dimension | Papers per Topic | Output |
|------|----------------|-------------|----------------------|-----------------|--------|
| `broad` | Stage 1 | Shallow | 1-2 | 5-8 per dim | Dimension summary, pool entries (shallow) |
| `cluster` | Stage 2 | Medium | 1-2 (supplement) | +5-10 per thin area | Updated pool (medium), candidates shortlist |
| `deep` | Stage 3 | Deep | 3-4 | 10-15 per topic | Deep analysis, pool entries (deep) |
| `refine` | Stage 4 | Deep | 2-3 (focused) | +5-10 per topic | Updated deep analysis, pool entries (deep) |

---

## Shared Resources

### Paper Pool (`thesis/search/paper-pool.md`)

All modes read and append to this file. Format:

```markdown
# Paper Pool

**Last updated:** {date}
**Total papers:** {N}

---

## {cite_key}

- **Title:** {title}
- **Authors:** {authors}
- **Year:** {year}
- **Source:** {arxiv | semantic_scholar}
- **Depth:** {shallow | medium | deep}
- **Dimensions:** [{dim_id}, ...]
- **Topics:** [{topic_id or empty}, ...]
- **Relevance:** {★ to ★★★★★}
- **Key Contribution:** {1 sentence}
- **Limitations:** {1 sentence}

---
```

**Rules:**
- `cite_key` format: `{firstAuthorLastName}{year}_{keyword}` — same as bibliography keys.
- A paper can belong to multiple dimensions and multiple topics.
- Depth can be upgraded (shallow → medium → deep) as the paper is read more thoroughly in later stages.
- Append papers at the end of the file. Update entries in-place only to upgrade depth or add dimensions/topics.

### Dimension Map (`thesis/search/dimensions.md`)

Tracks the conceptual dimensions discovered:

```markdown
# Conceptual Dimensions

| ID | Name | Description | Papers | Status |
|----|------|-------------|--------|--------|
| dim_1 | {name} | {1-line description} | {N} | searched |
| dim_2 | {name} | {1-line description} | {N} | interesting |
```

---

## Search Sources

### ArXiv

```
websearch_web_search_exa(
  query="arxiv.org papers about {query}",
  numResults=10
)
```

For full paper details:
```
webfetch(url="https://arxiv.org/abs/{paper_id}", format="markdown")
```

### Semantic Scholar

```
webfetch(
  url="https://api.semanticscholar.org/graph/v1/paper/search?query={query}&limit=10&fields=title,authors,year,abstract,externalIds,citationCount",
  format="text"
)
```

For full paper details:
```
webfetch(
  url="https://api.semanticscholar.org/graph/v1/paper/{paper_id}?fields=title,authors,year,abstract,externalIds,citationCount,references",
  format="text"
)
```

---

## Mode: `broad` — Broad Dimension Search

**Purpose:** Discover the landscape. Quick, wide, shallow.

### Procedure

1. **Read current state:** which dimensions are in `dimensions_searched`? Skip those.
2. **For each NEW dimension:**
   a. Run 1-2 broad queries per source:
      - `"{dimension} survey OR landscape OR review"`
      - `"{dimension} recent advances"`
   b. Collect top 5-8 unique papers per dimension.
   c. Read abstracts only. Mark depth: `shallow`.
   d. For each paper, extract into pool format: title, authors, year, source, key contribution, limitations.
3. **Deduplicate against existing pool** by ArXiv ID or title similarity (>80%).
4. **No clustering in broad mode** — this is pure exploration.
5. **Update** `dimensions_searched` in status.

### Quality Gate for `broad`
- [ ] New dimensions searched (≥1 query per source, per dimension)
- [ ] ≥3 new papers found per dimension (otherwise flag "thin dimension")
- [ ] All new papers written to pool with `shallow` depth
- [ ] Dimensions file updated

### Return Format
```
Status: completed — broad search
Mode: broad
Dimensions searched: {N}
Papers added: {M}
Thin dimensions: [{name}, ...]
```

---

## Mode: `cluster` — Supplementary Search & Topic Clustering

**Purpose:** Consolidate papers for clustering, supplement where needed, produce candidate topics.

### Procedure

1. **Read the paper pool.** Filter to papers in `interesting_dimensions`.
2. **Identify thin areas:** dimensions with < 5 papers.
3. **For thin dimensions:** execute 1-2 supplementary searches:
   - `"{dimension}" specific method approach`
   - Search for papers that bridge multiple interesting dimensions.
   - Read abstracts + intro/conclusion. Mark depth: `medium`.
   - Append to pool.
4. **Re-cluster the filtered pool** into 2-4 candidate research topics:
   - Group by shared research question/problem (NOT by dimension).
   - A good topic spans multiple interesting dimensions — that's a strength.
   - For each candidate: extract core question, novelty signal, feasibility indicators.
5. **Produce ranked shortlist** (write to `thesis/search/candidates.md`):

```markdown
# Candidate Research Topics

| # | Topic | Core Question | Novelty | Feasibility | Confidence | Key Paper |
|---|-------|--------------|---------|-------------|------------|-----------|
| 1 | {name} | {1-line} | ★★★★ | ★★★ | {depth distribution} | [@key] |
```

- **Confidence** = depth distribution, e.g. "2 deep, 8 medium, 12 shallow".
- Higher confidence = more deep/medium-read papers support this recommendation.

### Quality Gate for `cluster`
- [ ] Thin dimensions supplemented
- [ ] 2-4 candidate topics identified
- [ ] Each topic has: core question, novelty, feasibility, confidence rating
- [ ] Candidates file written
- [ ] Supplementary papers added to pool

### Return Format
```
Status: completed — cluster
Mode: cluster
Papers supplemented: {N}
Candidate topics: {M}
Confidence: {distribution summary}
```

---

## Mode: `deep` — Deep Topic Analysis

**Purpose:** For each shortlisted topic, search deeply and produce a complete, publication-quality analysis.

### Procedure

1. **For each shortlisted topic:**
   a. Run 3-4 precise queries per source:
      - `"{topic}" method approach technique`
      - `"{topic}" benchmark evaluation dataset`
      - `"{topic}" limitation challenge open problem`
      - `"{topic}" state of the art 2024 2025`
   b. Target 10-15 papers per topic.
   c. For each paper: read title, abstract, introduction, method, results, conclusion.
   d. Mark depth: `deep` in pool.
   e. Extract: core insight, method, limitation, relevance.
2. **Deduplicate** against existing pool. Any duplicate: upgrade depth from `shallow`/`medium` → `deep`.
3. **Generate deep analysis** for each topic (write to `thesis/search/deep-analysis.md`):

```markdown
## Deep Analysis: {Topic Name}

### Core Problem
{2-3 sentences — precise problem statement}

### Literature Overview
{2-3 paragraphs. Cite specific papers [@key].}

### Research Gap
{What is unsolved and why? Evidence from paper limitations.}

### Feasibility Assessment
| Factor | Rating | Evidence |
|--------|--------|----------|
| Data availability | High/Med/Low | {which datasets} |
| Method maturity | High/Med/Low | {what methods are available} |
| Experimental requirements | {description} | {compute/data estimate} |
| Novelty risk | High/Med/Low | {risk rationale} |

### Innovation Angle
{How would a new contribution differ from closest existing work?}

### Representative Papers (Top 5, deep-read)
| # | Paper | Core Insight | Limitation |
|---|-------|-------------|------------|
| 1 | [@key] ({year}) | {insight} | {limitation} |
```

### Quality Gate for `deep`
- [ ] 3-4 queries per topic, per source
- [ ] ≥10 new/upgraded deep papers per topic
- [ ] Each topic has complete deep analysis (all 5 sections)
- [ ] Deep analysis written to `thesis/search/deep-analysis.md`
- [ ] Pool updated with upgraded depth markers

### Return Format
```
Status: completed — deep
Mode: deep
Topics analyzed: {N}
Deep papers added/upgraded: {M}
```

---

## Mode: `refine` — Feedback-Driven Refinement

**Purpose:** Parse user feedback, derive new search directions, update analysis.

### Procedure

1. **Parse user feedback text.** Extract:
   - **Keywords:** new terms the user mentioned
   - **Methods:** specific techniques or approaches
   - **Constraints:** limitations or concerns the user raised
   - **Direction hints:** "more focus on X", "less focus on Y"
2. **Derive search queries** from the feedback:
   - Keywords → `"{topic} {keyword}"`
   - Methods → `"{topic} {method}"`
   - Constraints → `"{topic} limitation {constraint_area}"`
3. **Execute 2-3 focused queries** per topic, per source.
4. **Read new papers** → mark depth `deep`, append to pool.
5. **Update the deep analysis** for the relevant topics:
   - Incorporate new findings.
   - Adjust feasibility/novelty/risk based on new information.
   - Add a `## Refinement Notes (Iteration {N})` section documenting what changed.
6. **Any new dimensions** discovered from feedback → add to dimensions map → flag for potential broad search if user requests.

### Quality Gate for `refine`
- [ ] User feedback parsed into ≥1 specific search direction
- [ ] 2-3 queries per topic executed
- [ ] ≥3 new/upgraded papers per topic
- [ ] Deep analysis updated with refinement notes
- [ ] Pool updated

### Return Format
```
Status: completed — refine
Mode: refine
Iteration: {N}
Papers added: {M}
Analysis changes: {summary of what was updated}
```

---

## Pool Maintenance Rules

1. **Append new papers** at end of pool. Never delete.
2. **Upgrade depth** in-place: when a shallow paper is deep-read in a later stage, edit its pool entry to upgrade `Depth: shallow` → `deep`.
3. **Add dimensions/topics** to existing entries when a paper is found relevant to new dimensions or topics.
4. **Deduplicate on write**: check ArXiv ID and title similarity before appending.
5. **Pool integrity check** at end of each mode: total papers, depth distribution, coverage across dimensions.
