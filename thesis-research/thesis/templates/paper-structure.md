# Paper Structure — Section-by-Section Design Template

> Use this template when designing a paper outline. Fill in each section with purpose, key points, and references.

---

## Title: {PAPER_TITLE}
## Author: {AUTHOR}
## Target Venue: {VENUE}

---

## Thesis Statement

> 1-2 sentences. Must be specific and testable.

{Thesis statement here}

---

## 1. Introduction

**Purpose:** Establish context, motivate the problem, state contributions.

**Key Points:**
1. Hook — Why this area matters
2. Background context — What the reader needs to know
3. Problem statement — The specific gap or challenge
4. Contributions — What we contribute (numbered list)
5. Paper roadmap — "The remainder of this paper is organized as follows..."

**References to cite:**
- `{key1}`: {why}
- `{key2}`: {why}

**Visuals:** {None | Overview figure showing main idea}

---

## 2. Related Work

**Purpose:** Situate our work within the existing literature. Show what has been done and what remains unaddressed.

**Sub-topics:**

### 2.1 {Sub-topic A}
- **Description:** ...
- **Key papers:** `{key1}`, `{key2}`, `{key3}`
- **Common approach / limitation:** ...

### 2.2 {Sub-topic B}
- **Description:** ...
- **Key papers:** `{key4}`, `{key5}`
- **Common approach / limitation:** ...

**Gap Statement:**
> Despite progress in {area}, existing work does not address {specific gap}. Our work fills this gap by {approach}.

**References to cite:**
- `{key1}` through `{keyN}`

---

## 3. Methodology

**Purpose:** Formally define the problem and describe our approach in reproducible detail.

**Key Points:**
1. Problem formulation — Formal notation, definitions
2. Proposed method — Algorithm, architecture, key innovations
3. Training/inference procedure
4. Complexity analysis (if applicable)

**References to cite:**
- `{key1}`: {why}
- `{key2}`: {why}

**Visuals:**
- Figure 1: Architecture diagram / method overview
- Figure 2: Algorithm flow chart

---

## 4. Experiments

**Purpose:** Validate our method empirically against baselines.

**Key Points:**
1. Experimental setup — Datasets, metrics, hardware
2. Baselines — Methods compared against
3. Main results — Tables with key findings
4. Ablation studies — Component removal analysis
5. Qualitative analysis — Examples, error analysis
6. Discussion — Why results look this way

**Tables:**
- Table 1: Dataset statistics
- Table 2: Main results comparison
- Table 3: Ablation study

**Figures:**
- Figure 3: Performance comparison chart
- Figure 4: Qualitative examples

**References to cite:**
- `{baseline_key1}`: Baseline method
- `{baseline_key2}`: Baseline method
- `{dataset_key}`: Dataset source

---

## 5. Conclusion

**Purpose:** Summarize findings, restate contributions, acknowledge limitations, suggest future work.

**Key Points:**
1. Summary of what we did and found
2. Contributions restated in prose
3. Limitations — Honest assessment
4. Future work — Meaningful next steps

**References to cite:**
- {None or minimal — mirror introduction references}

**Visuals:** None

---

## Contributions (checklist)

- [ ] **Contribution 1:** {Specific, testable contribution}
- [ ] **Contribution 2:** {Specific, testable contribution}
- [ ] **Contribution 3:** {Specific, testable contribution}

Each contribution must:
- Be verifiable in the experiments section
- Use precise language (not "improved performance" but "15% improvement in accuracy on X benchmark")
- Be distinguishable from prior work

---

## Figure/Table Plan

| # | Type | Caption | Section | Story It Tells |
|---|------|---------|---------|----------------|
| 1 | Fig  | ...     | 1       | ...            |
| 2 | Fig  | ...     | 3       | ...            |
| 3 | Fig  | ...     | 4       | ...            |
| 4 | Tab  | ...     | 4       | ...            |
| 5 | Tab  | ...     | 4       | ...            |

---

## Writing Order (recommended)

| Order | Section | Reason |
|-------|---------|--------|
| 1st | Experiments | Core evidence; determines the story |
| 2nd | Methodology | Defines what was done |
| 3rd | Introduction | Frames the contribution (written last in practice) |
| 4th | Related Work | Positions against prior art |
| 5th | Conclusion | Mirrors introduction; summarizes findings |
