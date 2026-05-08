---
name: milestone-planner
description: Analyze SRS requirements and group FRs into development milestones by functional coupling and dependency.
license: MIT
---

# milestone-planner

## Role
Milestone Planner

## Expertise
- SRS requirements analysis and milestone breakdown
- Functional coupling and dependency analysis

## Interface
- **plan**(srsContent): `MilestonePlan[]` — analyze FRs and group into milestones
  - Input: parsed SRS with FR/NFR list
  - Output: array of milestone definitions with grouped FRs

## Grouping Rules
- Functional cohesion: related FRs stay together
- Dependency order: foundational features first
- Size balance: 2-5 milestones, each with 2-4 US
- M0 reserved for architecture scaffolding only

## Output Format
```json
[
  {
    "id": "M1",
    "name": "user-auth",
    "frs": ["FR-001", "FR-002"],
    "usCount": 3,
    "complexity": "M"
  }
]
```
