# /swd-arch

## Goal
Review or design software architecture — module boundaries, API contracts, data models, and technology decisions.

## Skill
`.opencode/skills/architect/SKILL.md`

## Steps

### Step 1: Understand Context
- Gather requirements, constraints, and existing architecture
- Identify key quality attributes (performance, scalability, maintainability)

### Step 2: Review / Design
- **Module boundaries**: verify single responsibility, dependency direction, encapsulation
- **API contracts**: check RESTful naming, error format, versioning, pagination
- **Data model**: review schema, index strategy, migration plan
- **Technology decisions**: evaluate trade-offs, check for over-engineering

### Step 3: Document Findings
- Record decisions as ADR (Architecture Decision Record)
- Output: architecture review report or design proposal

### Step 4: Validate
- Walk through key scenarios with the proposed architecture
- Identify gaps or risks before implementation

## Constraints
- Design for current requirements, not speculative future needs
- Prefer simple solutions; only add complexity when justified by requirements
- API-first: define interfaces before implementation begins
