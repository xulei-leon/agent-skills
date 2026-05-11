---
name: thesis-outline
description: >
  Builds a structured IMRaD paper outline in JSON format based on the selected research direction.
  Constructs section trees with key arguments, citation maps, argument chains, and visual plans,
  following standard academic paradigms for machine readability.
license: MIT
---

# thesis-outline — Paper Outline (JSON)

## Purpose

Based on the selected research direction, construct a structured outline following standard academic
paradigms (IMRaD: Introduction, Methods, Results, Discussion), with strict logical hierarchy and
argument support, output in **JSON format** for machine readability.

## Trigger

Loaded during the `/thesis-research` phase. Receives the selected innovation idea as input.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `innovation_ideas.md` | thesis_idea | Innovation points with the selected direction |
| `survey_matrix.md` | thesis_survey | Literature matrix for citation planning |
| `references.bib` | thesis_survey | Bibliography for citation keys |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `outline.json` | JSON | Machine-readable paper outline with full section tree, argument chain, and citation map |

---

## IMRaD Structure Definition

The outline must follow the IMRaD paradigm with strict logical nesting:

```
1. Introduction (I)
  1.1 Background & Motivation
  1.2 Problem Statement
  1.3 Proposed Approach (high-level)
  1.4 Contributions
  1.5 Paper Organization

2. Related Work (contextual, before Methods)
  2.1 Sub-area A
  2.2 Sub-area B
  2.3 Gap Summary

3. Methods (M)
  3.1 Problem Formulation
  3.2 Proposed Method
    3.2.1 Component A
    3.2.2 Component B
  3.3 Theoretical Analysis (if applicable)

4. Experiments / Results (R)
  4.1 Experimental Setup
  4.2 Main Results
  4.3 Ablation Studies
  4.4 Analysis & Discussion

5. Discussion / Conclusion (D)
  5.1 Summary of Findings
  5.2 Contributions Restated
  5.3 Limitations
  5.4 Future Work
```

---

## JSON Schema for Outline

The output `outline.json` must conform to this schema:

```json
{
  "meta": {
    "paper_title": "string",
    "paradigm": "IMRaD",
    "total_sections": 5,
    "total_planned_words": 0,
    "created_at": "ISO date"
  },
  "thesis": {
    "statement": "1-2 sentence core thesis",
    "contributions": [
      {
        "id": "C1",
        "statement": "specific contribution statement",
        "maps_to_section": "section_id",
        "validation_method": "how this will be proven"
      }
    ]
  },
  "sections": [
    {
      "id": "sec_intro",
      "number": "1",
      "title": "Introduction",
      "level": 1,
      "purpose": "what this section accomplishes",
      "planned_words": 800,
      "key_arguments": [
        {
          "id": "arg_1_1",
          "claim": "the specific claim this paragraph makes",
          "support": ["citation_key", "citation_key"],
          "logic_chain": "how this claim connects to the next"
        }
      ],
      "subsections": [],
      "citations_planned": ["key1", "key2"],
      "figures_planned": [],
      "tables_planned": []
    }
  ],
  "argument_chain": {
    "description": "The logical flow connecting all sections",
    "flow": [
      {"from": "arg_1_1", "to": "arg_1_2", "relation": "causes | supports | contrasts | exemplifies | summarizes"}
    ]
  },
  "citation_map": {
    "key1": {"sections": ["sec_intro", "sec_relwork"], "role": "foundational"},
    "key2": {"sections": ["sec_method"], "role": "baseline"}
  },
  "figure_table_plan": [
    {
      "id": "fig_1",
      "type": "figure",
      "caption": "Architecture overview",
      "section": "sec_method",
      "story": "what narrative this visual supports"
    }
  ],
  "writing_order": ["sec_method", "sec_exp", "sec_intro", "sec_relwork", "sec_conc"]
}
```

---

## Phase 1: Section Tree Construction

For each top-level section, define:

1. **Purpose**: One sentence — what does this section accomplish for the reader?
2. **Subsections**: Decompose into logical sub-units (level 2, optionally level 3)
3. **Key Arguments**: For each paragraph-level unit, define:
   - The **claim** it makes
   - The **support** it needs (citation keys from references.bib)
   - Its **logic_chain** — how it connects to the next argument
4. **Planned Words**: Estimate word count per subsection

## Phase 2: Argument Chain

Trace the logical flow across all arguments. Use relation types:
- `causes` — A leads to B
- `supports` — A provides evidence for B
- `contrasts` — A differs from B (used in related work)
- `exemplifies` — B is an example of A
- `summarizes` — B recaps A

This creates a directed graph that verifies the paper has no logical gaps.

## Phase 3: Citation Map

For every citation key in references.bib, map which sections use it and what role it plays:
- `foundational` — defines the field/problem
- `baseline` — compared against in experiments
- `method` — technique used or adapted
- `contrast` — contrasted in related work
- `support` — provides supporting evidence

## Phase 4: Visual Plan

Define every figure and table:
- Where it appears
- What story it tells
- What data it would contain

---

## Quality Gate

Before completing, verify:
- [ ] Follows IMRaD paradigm (5 top-level sections + subsections)
- [ ] All `key_arguments` have: claim, support (citation keys), logic_chain
- [ ] `argument_chain` connects all arguments without gaps
- [ ] `citation_map` references ONLY keys from references.bib
- [ ] `writing_order` specified (recommended: Methods → Experiments → Intro → Related → Conclusion)
- [ ] `contributions` list each maps to a section with validation method
- [ ] Valid JSON (parseable by standard JSON parser)
- [ ] `outline.json` written

## Return Format

```
Status: completed
Artifacts produced:
  - outline.json (sections: {N}, arguments: {M}, citations_planned: {K})
```
