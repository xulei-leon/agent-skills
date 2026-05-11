---
name: thesis-review
description: >
  Simulated anonymous peer review for academic papers. Evaluates drafts across four dimensions
  (logical coherence, experimental adequacy, academic standards, language quality) and produces
  a structured review report with prioritized, actionable fix recommendations.
license: MIT
---

# thesis-review — Critical Review

## Purpose

Simulate an anonymous peer reviewer's perspective. Conduct a critical review from four dimensions:
**logical coherence**, **experimental adequacy**, **academic standards**, and **language quality**.
Produce a specific revision checklist with actionable fix items.

## Trigger

Loaded during the `/thesis-write` phase. Receives the complete draft and outline.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `draft.md` | thesis_write | Complete paper draft |
| `outline.json` | thesis_outline | Original outline for structure comparison |
| `references.bib` | thesis_survey | Bibliography for citation audit |
| `innovation_ideas.md` | thesis_idea | Original contribution claims for fidelity check |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `review_report.md` | Markdown | Structured review with 4-dimension scoring and prioritized fix list |

---

## Reviewer Persona

Adopt the mindset of an **anonymous peer reviewer** for a top-tier venue:

> "I am a domain expert who has read 100+ papers in this area. I am skeptical by default and demand
> rigorous evidence. I will not be impressed by claims without proof. I read the abstract first,
> then skim the results, then decide if the paper is worth my full attention. I have limited time
> and low tolerance for unclear writing."

Ask these questions constantly:
- *"Why should I believe this claim?"*
- *"Is this contribution really novel, or just a minor tweak?"*
- *"Could I reproduce this work from the description?"*
- *"Does the evidence actually support the conclusion?"*

---

## Four Review Dimensions

### Dimension 1: Logical Coherence (Weight: 30%)

| Sub-criterion | What to Check |
|---------------|---------------|
| Thesis clarity | Is the core thesis clearly stated? Can you find it in one sentence? |
| Argument chain | Does each section's argument follow from the previous? (Compare against outline.json.argument_chain) |
| Claim-support alignment | Is every major claim supported by either: an experiment result, a citation, or formal proof? |
| Internal consistency | Do the introduction's contributions match the conclusion's restatements? Are there contradictions? |
| Structure adherence | Does the paper follow the outline's section tree? Any missing or extra sections? |
| Gap-to-contribution link | Does the problem statement (gap) directly connect to the stated contributions? |

### Dimension 2: Experimental Adequacy (Weight: 30%)

| Sub-criterion | What to Check |
|---------------|---------------|
| Dataset appropriateness | Are the datasets standard for this field? Are they large enough? |
| Baseline fairness | Are baselines the actual state-of-the-art? Are they tuned fairly? |
| Metric validity | Do the metrics actually measure what the paper claims? |
| Statistical rigor | Are error bars / confidence intervals / significance tests reported? |
| Ablation completeness | Do ablation studies isolate the contribution of each novel component? |
| Reproducibility | Could a competent researcher reproduce these results from the description? |
| Result overclaiming | Do the conclusions overstate what the data supports? |

### Dimension 3: Academic Standards (Weight: 25%)

| Sub-criterion | What to Check |
|---------------|---------------|
| Literature coverage | Are seminal papers in the area cited? Is the related work section comprehensive? |
| Citation accuracy | Do citations actually support the claims they're attached to? (Spot-check 3-5) |
| Prior work acknowledgment | Is there any uncited prior work that is clearly relevant? |
| Novelty honesty | Is the contribution clearly distinguished from prior work, or is the novelty overstated? |
| Ethical considerations | Are potential negative impacts or limitations discussed? |
| Self-citation balance | Is self-citation appropriate and not excessive? |

### Dimension 4: Language Quality (Weight: 15%)

| Sub-criterion | What to Check |
|---------------|---------------|
| Clarity | Can a non-native English speaker follow the argument? |
| Conciseness | Are there redundant sentences? Overly long paragraphs (>250 words)? |
| Terminology consistency | Is the same concept called the same thing throughout? |
| Grammar & style | Typos, subject-verb agreement, article usage |
| Academic register | No conversational tone ("a lot", "really", "very"), no contractions |
| Figure/table references | Are all figures and tables referenced in the text before they appear? |

---

## Output: Review Report

Write `review_report.md` with: overall assessment, 4-dimension scoring table, section-by-section
critique (strengths + weaknesses + specific suggestions), argument chain audit, citation audit
(with counts, spot-checks, missing/unused entries), and prioritized fix list (Critical / Major / Minor).

---

## Review Scoring

| Dimension | Score (1-10) | Weight | Weighted | Verdict |
|-----------|-------------|--------|----------|---------|
| Logical Coherence | ?/10 | 30% | ? | ✓/⚠/✗ |
| Experimental Adequacy | ?/10 | 30% | ? | ✓/⚠/✗ |
| Academic Standards | ?/10 | 25% | ? | ✓/⚠/✗ |
| Language Quality | ?/10 | 15% | ? | ✓/⚠/✗ |
| **Total** | | | **?/100** | |

Verdict: ✓ = Pass, ⚠ = Needs improvement, ✗ = Critical issue

## Decision Thresholds

| Overall Score | Recommendation |
|---------------|----------------|
| Score ≥ 80 | ACCEPT — minor fixes only, proceed to format |
| Score 60-79 | MINOR REVISION — fix identified issues, re-review |
| Score 40-59 | MAJOR REVISION — substantial rewrite needed |
| Score < 40 | REJECT — fundamental issues, reconsider approach |

---

## Quality Gate

Before completing, verify:
- [ ] All 4 dimensions scored with sub-criteria evaluated
- [ ] Overall recommendation explicitly stated
- [ ] Every section has: strengths, weaknesses, specific suggestions
- [ ] Argument chain audited against outline
- [ ] Citation audit completed with counts and spot-checks
- [ ] Issues categorized into Critical / Major / Minor
- [ ] Each issue has a specific fix (not just "improve X")
- [ ] `review_report.md` written

## Return Format

```
Status: completed
Overall recommendation: {ACCEPT | MINOR REVISION | MAJOR REVISION | REJECT}
Overall score: {X}/100
Issues found: {N} (Critical: {A}, Major: {B}, Minor: {C})
Artifacts produced:
  - review_report.md
```
