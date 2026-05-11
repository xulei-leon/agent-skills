---
name: thesis-survey
description: >
  Targeted literature survey for a confirmed research topic. Searches ArXiv and Semantic Scholar
  with precise queries, produces a structured literature review matrix with background context
  and limitations, and generates BibTeX references. Unlike thesis-topic-explorer, this is a
  focused deep survey — not broad exploration.
license: MIT
---

# thesis-survey — Focused Literature Survey

## Purpose

Search external academic databases (ArXiv, Semantic Scholar) via API, automatically extract core
papers for a CONFIRMED research topic, and generate a structured **Literature Review Matrix**
that includes research background and limitations for each paper.

This is the FOCUSED survey phase. Unlike `thesis-topic-explorer`, the topic is already chosen —
the search is targeted and deep, not broad and exploratory.

## Trigger

Loaded during the `/thesis-research` phase. Receives the confirmed topic and keyword list
from `thesis/target.md`.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `selected_topic` | `thesis/target.md` | The confirmed research topic |
| `keywords` | `thesis/target.md` | Key search terms (5-8) |
| `venue` | `thesis/target.md` | Target venue (optional, for recency filter) |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `survey_matrix.md` | Markdown | Structured literature review matrix |
| `references.bib` | BibTeX | Bibliography entries for all surveyed papers |

---

## External Data Sources

### Source 1: ArXiv

Use `websearch_web_search_exa` with domain-specific queries:
```
websearch_web_search_exa(
  query="arxiv.org papers about {topic} {keyword}",
  numResults=10
)
```

Fetch paper details via `webfetch`:
```
webfetch(url="https://arxiv.org/abs/{paper_id}", format="markdown")
```

### Source 2: Semantic Scholar

Search via API endpoint:
```
webfetch(
  url="https://api.semanticscholar.org/graph/v1/paper/search?query={topic} {keyword}&limit=10&fields=title,authors,year,abstract,externalIds,citationCount",
  format="text"
)
```

For paper details:
```
webfetch(
  url="https://api.semanticscholar.org/graph/v1/paper/{paper_id}?fields=title,authors,year,abstract,externalIds,citationCount,references,publicationTypes,journal",
  format="text"
)
```

---

## Search Strategy

### Phase 1: Targeted Multi-Keyword Search

For the confirmed topic, run searches against both ArXiv and Semantic Scholar:
1. **Core topic search**: `"{topic}"` (max 10 results)
2. **Recent search**: `"{topic}" 2024 2025` (focus on last 2 years)
3. **Method-specific**: `"{topic}" method approach technique`
4. **Benchmark search**: `"{topic}" benchmark dataset evaluation`

Collect all unique papers across sources (target 15-25).

### Phase 2: Deduplication

Merge results, deduplicate by:
- ArXiv ID match (across ArXiv and Semantic Scholar)
- Title similarity (>80% fuzzy match)

### Phase 3: Paper Deep-Read

For each unique paper, extract to this structure:

```json
{
  "id": "paper_001",
  "title": "...",
  "authors": ["..."],
  "year": 2024,
  "source": "arxiv|semantic_scholar",
  "arxiv_id": "2401.12345",
  "doi": "10.xxxx/xxxxx",
  "abstract": "...",
  "citation_count": 42,
  "venue": "NeurIPS 2024",
  "keywords_extracted": ["...", "..."],
  "primary_contribution": "...",
  "method_category": "theoretical|empirical|system|survey",
  "background_context": "...",
  "limitations_stated": "..."
}
```

Key fields for the matrix:
- **background_context**: The research context this paper operates in (what problem space)
- **limitations_stated**: Explicitly stated limitations OR limitations you infer from the method description

### Phase 4: Category Clustering

Group papers into 3-5 thematic categories. Each category should represent a distinct approach,
paradigm, or sub-problem within the research topic.

---

## Output: Literature Review Matrix

Write `survey_matrix.md` using this template:

```markdown
# Literature Review Matrix — {paper_title}

**Search Date:** {date}
**Sources:** ArXiv, Semantic Scholar
**Total Papers Retrieved:** {N}
**After Deduplication:** {M}
**Categories Identified:** {K}

---

## Research Landscape Overview
{2-3 paragraph narrative summarizing the field state — what is known, what approaches dominate, where are the tensions?}

---

## Paper Distribution by Category

| Category | Paper Count | Dominant Approach | Representative Venue |
|----------|-------------|-------------------|---------------------|
| {Cat 1}  | {N}         | ...               | ...                 |
| ...      | ...         | ...               | ...                 |

---

## Category 1: {Category Name}

**Description:** {What unifies these papers — shared problem, common method, or paradigm}

### Paper Matrix

| # | Paper (Year) | Core Contribution | Background Context | Stated Limitations | Method Category | Relevance |
|---|-------------|-------------------|-------------------|-------------------|----------------|-----------|
| 1 | {title} ({year}) | {1-sentence contribution} | {context} | {limitation} | {category} | ★★★★★ |
| 2 | ... | ... | ... | ... | ... | ... |

### Synthesis
{1 paragraph: what does this cluster tell us? What patterns emerge? What are the common limitations across these papers?}

---

(repeat for each category)

---

## Cross-Category Observations

### Recurring Limitations
| Limitation Theme | Papers Affected | Significance |
|-----------------|-----------------|--------------|
| {limitation A}  | {N} papers      | High/Med/Low |
| {limitation B}  | {N} papers      | High/Med/Low |

### Methodological Trends
{What approaches dominate? What is emerging? What is declining?}

### Open Problems
{What are the clearly unsolved problems visible across categories?}

---

## Top-10 Priority Papers
Ranked by relevance × citation count × recency:
1. **{title}** ({year}) — {key contribution}. *{N} citations. Venue: {venue}.*
2. ...
```

---

## Output: Bibliography

Append BibTeX entries to `references.bib`:

```bibtex
@article{author2024title,
  title   = {Full Paper Title},
  author  = {First Author and Second Author},
  year    = {2024},
  journal = {arXiv preprint},
  eprint  = {arXiv:XXXX.XXXXX},
  archivePrefix = {arXiv},
  doi     = {10.xxxx/xxxxx}
}
```

Citation key format: `{firstAuthorLastName}{year}_{keyword}`

---

## Quality Gate

Before completing, verify:
- [ ] Searches executed against BOTH ArXiv and Semantic Scholar
- [ ] ≥15 papers in the survey after deduplication
- [ ] Papers organized into 3-5 thematic categories (not a flat list)
- [ ] Every paper entry includes: core contribution, background_context, limitations_stated
- [ ] Cross-category observations section completed (recurring limitations, trends, open problems)
- [ ] Top-10 priority-ranked papers listed
- [ ] `survey_matrix.md` written
- [ ] `references.bib` written with ≥15 entries

## Return Format

```
Status: completed
Artifacts produced:
  - survey_matrix.md (papers: {N}, categories: {K})
  - references.bib (entries: {N})
```
