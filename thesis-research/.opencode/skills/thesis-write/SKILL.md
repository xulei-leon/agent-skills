---
name: thesis-write
description: >
  Academic paper section writing. Expands each section from the JSON outline, automatically links
  citation keys from the bibliography, and produces Markdown-formatted paper drafts using formal
  academic language following IMRaD conventions.
license: MIT
---

# thesis-write — Section Writing

## Purpose

Expand each section based on the outline, automatically link citation keys from the bibliography,
and produce a **Markdown-formatted** paper draft using academic language.

## Trigger

Loaded during the `/thesis-write` phase. Receives the outline (JSON) and bibliography from
the research phase artifacts.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `outline.json` | thesis_outline | JSON outline with section tree + argument chain + citation map |
| `references.bib` | thesis_survey | BibTeX bibliography |
| `survey_matrix.md` | thesis_survey | Literature matrix for detailed paper context |
| `innovation_ideas.md` | thesis_idea | Innovation context for contribution framing |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `sections/{id}.md` | Markdown | One file per top-level section (5 files) |
| `draft.md` | Markdown | Complete assembled draft (all sections) |

---

## Writing Order

Follow the order specified in `outline.json.writing_order` (recommended: Methods → Experiments →
Introduction → Related Work → Conclusion). This ensures the "story" is built around known results
rather than promises.

---

## Section Writing Procedure

For each section in `outline.json.sections[]`:

### Step 1: Parse Section Definition

From the outline, extract:
- `purpose` — the section's role
- `key_arguments[]` — paragraph-level claims with citation support
- `planned_words` — target word count
- `subsections[]` — structural hierarchy

### Step 2: Write Each Argument as a Paragraph

For each `key_arguments[i]`, write one paragraph:
1. **Topic sentence** — state the `claim`
2. **Support** — cite the `support` keys using Markdown citation syntax: `[@citation_key]`
3. **Logic** — connect to the next argument per the `logic_chain`

### Step 3: Citation Auto-Linking

For every `citation_key` in the argument's `support` array, generate a Markdown citation:
```markdown
According to Author et al. [@smith2024_method], ...
... as demonstrated in recent work [@jones2023_approach; @lee2024_technique].
```

Verify every citation key exists in `references.bib`. If a key is missing, flag it in a
`citation_warnings` section at the bottom of the draft.

### Step 4: Markdown Formatting Rules

| Element | Markdown Syntax |
|---------|----------------|
| Section heading | `## {number} {title}` |
| Subsection heading | `### {number} {title}` |
| Subsubsection heading | `#### {number} {title}` |
| Citation (single) | `[@citation_key]` |
| Citation (multiple) | `[@key1; @key2]` |
| Inline math | `$E = mc^2$` |
| Display math | `$$\mathcal{L}(\theta) = \frac{1}{N}\sum_{i=1}^{N} \ell(x_i;\theta)$$` |
| Figure placeholder | `![Caption](figures/filename.pdf)` |
| Table | GitHub-flavored Markdown table |
| Bold emphasis | `**key term**` |
| Footnote | `[^1]: footnote text` |

---

## Section-Specific Guidelines

### Introduction
- **Opening hook**: Start with a concrete problem or statistic, not a generic "In recent years..."
- **Background**: 2 paragraphs max — give only what's needed to understand the problem
- **Problem statement**: End with "However, ..." or "Despite this progress, ..." to signal the gap
- **Contributions**: Bullet list after problem statement
- **Roadmap**: "The remainder of this paper is organized as follows. Section 2..."

### Related Work
- Group by theme, not paper-by-paper
- Each subsection starts with a topic sentence defining the theme
- End each subsection with limitations of that approach
- Final paragraph: the gap statement (bridge to your work)
- Use `[@key]` liberally — this section is citation-dense

### Methods
- Start with problem formulation in math notation
- Use `$$...$$` for key equations
- Number equations where possible
- Algorithm descriptions: numbered steps in plain Markdown
- Be specific enough for reproducibility

### Experiments

**IMPORTANT**: The agent cannot execute experiments. Write the experimental **DESIGN** — not results.
Include placeholders marked with `<!-- TODO -->` for sections that need real data.

- **Datasets**: Which datasets would be used? Their statistics, splits.
- **Metrics**: What metrics would be reported? Why these metrics?
- **Baselines**: Which methods should be compared against? Fairness considerations.
- **Experimental setup**: Hardware, hyperparameters, training details (if known).
- **Expected results table**: Markdown tables with placeholder values `<!-- TODO: fill with actual results -->`.
- **Ablation plan**: Which component removals would isolate contributions.
- **Analysis plan**: How results would be interpreted.

### Conclusion
- Start with: "This paper presented..."
- Mirror the introduction's contribution list (in prose, not bullets)
- Limitations: be honest and specific
- Future work: 2-3 concrete directions, not vague "more research is needed"

---

## Output: Section Files

Write individual section files:
- `sections/1_introduction.md`
- `sections/2_related_work.md`
- `sections/3_methods.md`
- `sections/4_experiments.md`
- `sections/5_conclusion.md`

## Output: Assembled Draft

Write `draft.md` by concatenating all sections in order, with a title header:

```markdown
# {paper_title}

**Authors:** {author_names}
**Date:** {date}

---

## Abstract
{first paragraph of introduction, slightly condensed}

---

{content of all 5 sections in order}
```

Include a `Citation Warnings` section at the end if any citation keys were not found in references.bib.

---

## Quality Gate

Before completing, verify:
- [ ] All 5 section files written
- [ ] `draft.md` assembled with all sections
- [ ] Word count per section within ±20% of `planned_words`
- [ ] Every `citation_key` in `key_arguments[].support[]` appears as `[@key]` in the text
- [ ] Citation warnings collected if any keys missing
- [ ] Follows `writing_order` from outline
- [ ] Uses academic formal language (no contractions, no casual expressions)
- [ ] All sections have clear topic sentences and logical flow per argument chain
- [ ] Experiments section clearly marked with TODO placeholders for real results

## Return Format

```
Status: completed
Artifacts produced:
  - sections/1_introduction.md ({word_count} words)
  - sections/2_related_work.md ({word_count} words)
  - sections/3_methods.md ({word_count} words)
  - sections/4_experiments.md ({word_count} words)
  - sections/5_conclusion.md ({word_count} words)
  - draft.md ({total_word_count} words, {citation_count} citations)
Warnings:
  - {N} citations not found in references.bib
  - {M} experiment results marked as TODO
```
