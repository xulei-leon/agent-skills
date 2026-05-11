---
name: thesis-revise
description: >
  Draft revision based on peer review feedback. Performs localized restructuring and polishing
  of specified sections, optimizes sentence expression while preserving original meaning, and
  synchronizes cross-section context. Runs in a loop with thesis-review (max 3 cycles).
license: MIT
---

# thesis-revise — Draft Revision

## Purpose

Based on the review feedback, perform localized restructuring and polishing of specified sections.
Optimize sentence expression while preserving original meaning, and synchronously update affected
contextual logic across sections.

## Trigger

Loaded during the `/thesis-write` phase as part of the review↔revise loop. Receives the review
report and the current draft. Runs up to 3 iterations with thesis-review.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `review_report.md` | thesis_review | Prioritized fix list with specific suggestions |
| `draft.md` | thesis_write | Current full draft |
| `sections/*.md` | thesis_write | Individual section files |
| `outline.json` | thesis_outline | Original outline for structure reference |
| `references.bib` | thesis_survey | Bibliography |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `sections/{id}.md` | Markdown | Revised section files (updated in-place) |
| `draft.md` | Markdown | Updated assembled draft |
| `revision_log.md` | Markdown | Change log tracking all modifications |

---

## Revision Procedure

### Step 1: Triage Fixes

Read `review_report.md`. Sort issues into execution order:

1. **Critical issues first** — these may change multiple sections
2. **Major issues second** — significant improvements
3. **Minor issues last** — polishing

For each issue, determine:
- **Scope**: single section / multi-section / global
- **Type**: content change / structural change / language polish / citation fix
- **Sections affected**: which files need editing

### Step 2: Apply Fixes by Scope

#### Single-Section Fixes

Use the `edit` tool to make precise replacements in the affected section file.

Rules:
- Replace only the necessary text — do not rewrite entire sections
- Preserve all citations that are NOT part of the fix
- Maintain paragraph structure unless the fix requires reordering

#### Multi-Section Fixes (Cross-Cutting)

When a fix affects multiple sections (e.g., changing a term definition used across the paper):
1. Identify ALL occurrences using `grep` across `sections/*.md`
2. Apply the change consistently to every occurrence
3. Verify no orphaned references remain

#### Structural Fixes

When the review requests section reorganization (e.g., "move ablation to a subsection"):
1. Read the affected section(s) fully
2. Reconstruct the section structure per the fix
3. Ensure all internal cross-references still resolve
4. Update outline argument chain if structural changes break the original logic

#### Citation Fixes

When the review identifies missing/wrong citations:
1. Verify the target citation key exists in `references.bib`
2. Replace the incorrect `[@key]` with the correct one
3. If the review suggests adding a NEW citation not in references.bib:
   - Add a `TODO` comment: `<!-- TODO: add citation for {reason} -->`
   - Add to a `pending_citations` list in revision log

### Step 3: Language Polishing

For each edited section, apply these language rules:

| Principle | Before | After |
|-----------|--------|-------|
| Remove redundancy | "In this paper, we propose a novel new method for..." | "We propose a method for..." |
| Active voice | "It was observed that..." | "We observed..." |
| Specific > vague | "significant improvement" | "15.3% improvement" |
| Short sentences | Run-ons > 40 words | Split into 2 sentences |
| Remove hedging overload | "may potentially somewhat improve" | "may improve" |
| Consistent terminology | Same concept called different names | Use one term throughout |

### Step 4: Context Synchronization

After all edits, verify cross-section consistency:

1. **Contribution alignment**: Introduction's contributions list ↔ Conclusion's restatements
2. **Terminology**: `grep` for key terms across all sections — ensure consistent naming
3. **Citation consistency**: Same paper cited with same `[@key]` everywhere
4. **Cross-reference validity**: If section numbers change, update all cross-references

### Step 5: Rebuild Draft

After all section edits, reassemble `draft.md` from the updated section files.

---

## Output: Revision Log

Write `revision_log.md` with: cycle number, review score basis, changes applied table
(Critical / Major / Minor), context synchronization report, unresolved items, and statistics.

---

## Self-Correction Rules

During revision, if you encounter:

| Situation | Action |
|-----------|--------|
| A suggested fix would break another section's logic | Do NOT apply it. Note the conflict in unresolved items. |
| A suggested citation does not exist in references.bib | Add as TODO, note in pending_citations |
| Two fixes contradict each other | Apply the higher-priority one, note the conflict |
| A fix requires data not available | Add TODO, note as unresolved |
| Original meaning would be lost | Preserve meaning, rephrase only for clarity |

---

## Quality Gate

Before completing, verify:
- [ ] All Critical issues from review addressed or explicitly noted as unresolved
- [ ] All Major issues addressed where feasible
- [ ] `grep` confirms terminology consistency across sections
- [ ] Contribution statements in Introduction and Conclusion aligned
- [ ] `draft.md` rebuilt from revised sections
- [ ] `revision_log.md` written with change tracking and unresolved items
- [ ] No orphaned `[@key]` citations without matching bib entry

## Return Format

```
Status: completed
Cycle: {N} of 3
Fixes applied: {N_critical} critical, {N_major} major, {N_minor} minor
Unresolved: {N_unresolved}
Sections modified: {list}
Artifacts produced:
  - sections/*.md (updated)
  - draft.md (rebuilt)
  - revision_log.md
```
