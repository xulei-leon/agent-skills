---
name: thesis-idea
description: >
  Innovation idea generation from literature gaps. Compares survey findings against the user's
  research concept, identifies existing research gaps, and uses logical reasoning to generate
  3-5 academically novel research directions with feasibility and risk assessments.
license: MIT
---

# thesis-idea — Innovation Idea Generation

## Purpose

Compare survey findings against the user's initial research concept, identify existing research gaps,
and use logical reasoning to generate 3-5 academically novel research directions and innovation points.

## Trigger

Loaded during the `/thesis-research` phase. Receives the survey matrix and user's topic.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `survey_matrix.md` | thesis_survey | Literature review with gaps and limitations |
| `selected_topic` | `thesis/target.md` | The confirmed research topic |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `innovation_ideas.md` | Markdown | 3-5 innovation points with gap-to-idea mapping |

---

## Gap-to-Idea Reasoning Framework

### Step 1: Extract Gaps from Survey

From `survey_matrix.md`, extract:

| Source in Survey | What to Extract |
|-----------------|-----------------|
| "Stated Limitations" column | Explicit limitations acknowledged by prior work |
| "Recurring Limitations" table | Cross-paper limitation themes |
| "Open Problems" section | Unsolved problems identified in the survey |

Produce a **Gap Inventory**:

```markdown
### Gap Inventory

| Gap ID | Description | Source Papers | Type |
|--------|-------------|---------------|------|
| GAP-1  | {description} | {paper_ids} | theoretical | empirical | methodological |
| GAP-2  | ... | ... | ... |
```

### Step 2: Analyze Topic Against Gaps

Analyze the confirmed topic:
- What gap does it attempt to address?
- What approach does it suggest?
- Where does it overlap with existing work?
- Where does it differ?

```markdown
### Topic-Gap Alignment

**Topic:** {selected_topic}

**Gap Alignment:**
- Directly addresses: GAP-X, GAP-Y
- Partially addresses: GAP-Z
- Does not address: GAP-W

**Strengths:** ...
**Weaknesses:** ...
**Overlap with existing work:** ...
```

### Step 3: Logical Deduction of Innovation Points

For each gap (or gap combination), use logical reasoning to derive innovation directions:

**Reasoning Pattern:**
```
Given:
  - GAP-X: existing work does not {capability}
  - The field is moving toward {trend}
  - Method {M} has shown promise in adjacent area {A}

Therefore:
  - A novel direction is: apply {M} to address {capability} in {domain}
  - This is novel because: no prior work combines {M} with {domain} for {capability}
  - Expected contribution: {specific outcome}
```

Generate 3-5 innovation points. Each must:

| Requirement | Check |
|-------------|-------|
| Maps to a specific gap | GAP-ID referenced |
| Has a clear approach direction | Method or technique proposed |
| Is distinguishable from existing work | Specific reference to closest paper(s) |
| Is testable | Expected experimental validation described |
| Has impact potential | Why it matters beyond just filling a gap |

---

## Output: Innovation Ideas

Write `innovation_ideas.md`:

```markdown
# Innovation Ideas — {paper_title}

**Date:** {date}
**Number of Ideas Generated:** {N}

---

## Gap Inventory
{from Step 1}

## Topic-Gap Alignment
{from Step 2}

---

## Innovation Points

### Idea 1: {Short Descriptive Title}
**Innovation Type:** {theoretical advance | methodological innovation | application extension | system design | novel combination}

**Addresses Gap:** GAP-{X}
**Closest Prior Work:** {paper reference} — {why it's close but insufficient}

**Core Idea:**
{2-3 sentences describing the core innovation}

**Novelty Justification:**
- What is new: {specific novelty claim}
- Why it's not obvious: {combination or insight that isn't trivial}
- Evidence of gap: {references to papers that don't do this}

**Approach Sketch:**
1. {Step 1 of the proposed approach}
2. {Step 2}
3. {Step 3}

**Validation Strategy:**
- Primary metric: {what to measure}
- Baselines: {what to compare against}
- Expected outcome: {what success looks like}

**Risk Assessment:**
- Technical risk: {High/Med/Low} — {why}
- Novelty risk: {High/Med/Low} — {why}
- Feasibility: {High/Med/Low} — {why}

**Impact Potential:** {High/Med/Low}
- Why: {reasoning about significance to the field}

---

(repeat for each idea)

---

## Comparative Evaluation

| Criterion | Idea 1 | Idea 2 | Idea 3 | Idea 4 | Idea 5 |
|-----------|--------|--------|--------|--------|--------|
| Novelty | ★★★★ | ... | ... | ... | ... |
| Feasibility | ★★★ | ... | ... | ... | ... |
| Impact | ★★★★★ | ... | ... | ... | ... |
| Alignment with topic | ★★★★ | ... | ... | ... | ... |
| **Overall** | **16/20** | ... | ... | ... | ... |

## Recommendation

**Primary recommendation:** Idea {N} — {reasoning}
**Alternative:** Idea {M} — {reasoning}
**High-risk / high-reward:** Idea {K} — {reasoning}
```

---

## Quality Gate

Before completing, verify:
- [ ] Gap inventory extracted from survey (≥5 gaps identified)
- [ ] Topic analyzed with strengths/weaknesses/overlap
- [ ] 3-5 innovation points generated
- [ ] Each idea: maps to gap, has novelty justification, approach sketch, validation strategy, risk assessment
- [ ] Comparative evaluation table completed
- [ ] Recommendation provided
- [ ] `innovation_ideas.md` written

## Return Format

```
Status: completed
Artifacts produced:
  - innovation_ideas.md (gaps: {N}, ideas: {M})
```
