---
name: architect
description: "Use when reviewing or designing software architecture. Covers module boundaries, API contracts, data modeling, integration points, and technology trade-offs."
license: MIT
---

# architect

## Purpose
Review an existing architecture or propose a new one with explicit trade-offs, assumptions, and validation risks.

## Required Inputs
- Target scope: system, service, module, or change under review
- Problem statement, requirements, or design question
- Known constraints such as scale, latency, security, compliance, budget, or team limits

## Optional Inputs
- Existing diagrams, ADRs, API docs, schemas, or repo structure
- Known incidents, bottlenecks, or migration concerns
- Preferred stack, deployment model, or operational constraints

## Clarify Before Proceeding
- If the scope is unclear, ask which system or change is being reviewed.
- If requirements are missing, ask for the key use cases and quality attributes.
- If constraints are missing, ask which trade-offs matter most: simplicity, speed, cost, reliability, or extensibility.

## Execution Rules
1. Identify whether the task is architecture review, fresh design, or option comparison.
2. Separate confirmed facts from inferred assumptions.
3. Evaluate module boundaries, interfaces, data flow, integration points, failure modes, and operational impact.
4. Prefer the simplest design that satisfies current requirements.
5. Recommend ADR-style documentation only when the project already uses it or the user asks for a decision record.

## Output Template

```markdown
## Architecture Report

### 1. Scope
{system or change being evaluated}

### 2. Assumptions
- {assumption 1}
- {assumption 2}

### 3. Current State or Options
{existing design summary or candidate options}

### 4. Findings or Decisions
- {finding or decision} — {reasoning and trade-off}

### 5. Recommended Direction
{proposed module boundaries, interfaces, data model, and operational approach}

### 6. Risks and Gaps
- {risk} — {impact and mitigation}

### 7. Next Validation
{scenario walkthrough, spike, benchmark, or interface check}
```

## Constraints
- Design for current requirements, not speculative future states.
- Distinguish observations, assumptions, and recommendations explicitly.
- Do not force platform, framework, or process changes without justification.
- Keep ownership, testing, and operability in view for every major component.

## Fallbacks
- If only source code is available, infer the current architecture from code and mark assumptions clearly.
- If no diagrams or docs exist, produce a lightweight textual architecture summary instead of blocking.
- If critical requirements remain unknown, stop after listing the minimum questions that must be answered.
