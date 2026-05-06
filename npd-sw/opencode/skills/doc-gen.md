# doc_gen

## Purpose
Generate NPD-SW Model lifecycle documents from templates and user input.

## Capabilities
- **charter**: create `docs/01-Concept/Charter.md` from project description
- **marketResearch**: create `docs/01-Concept/Market_Research.md`
- **srs**: create `docs/02-Requirement/SRS.md` using `docs/templates/srs-template.md`
- **sad**: create `docs/03-Design/SAD.md` using `docs/templates/sad-template.md`
- **milestoneSpec**: create `docs/02-Requirement/User-Story/M{n}-{name}.md` using `docs/templates/spec-template.md`
- **rtm**: create `docs/03-Design/RTM.md` with traceability matrix

## Templates
Located in `docs/templates/`:
- `srs-template.md` — SRS template
- `sad-template.md` — SAD template
- `st-template.md` — System test template
- `spec-template.md` — User Story spec template

## Constraints
- Always include `Version: x.y.z` in document header
- All FR/NFR must be numbered (`FR-001`, `NFR-001`)
- Each document must be traceable to requirements
