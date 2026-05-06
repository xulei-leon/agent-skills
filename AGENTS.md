# Agent Skills

Root of a **single-project** workspace — one template project `npd-sw/`.

## npd-sw — NPD-SW lifecycle template

A **project starter template** using OpenCode's Command + Skills pattern. Not an application — no build, no tests, no runtime. Meant to be copied into new projects.

### Structure

| Layer | Path | Role |
|-------|------|------|
| Commands | `opencode/commands/npd-*.md` | **Thin** entrypoints — Goal + Workflow ref + Constraints only |
| Workflows | `opencode/workflows/phase*.md` | Detailed step-by-step procedures, reference skills |
| Skills | `opencode/skills/*.md` | Reusable domain logic per role (analyst, architect, programmer, etc.) |

### Phases

| Cmd | Phase | Exit Gate |
|-----|-------|-----------|
| `/npd-concept` | 0 — Concept (Research → Charter) | `Charter Approved` |
| `/npd-requirement` | 1 — Requirement (SRS + ST) | `Phase 1 Approved` |
| `/npd-design` | 2 — Design (SAD + RTM + backlog) | `Phase 2 Approved` |
| `/npd-develop` | 3 — Develop (TDD per milestone) | `Review Passed: M{n}` |
| `/npd-test` | 4 — System Test | All ST pass |
| `/npd-launch` | 5 — Launch (build + changelog + tag) | Build success |

### Key conventions

- **TDD is mandatory**: write UT before implementation code.
- **Gate-driven**: each phase requires approval signal (`Phase N Approved`, `Review Passed: M{n}`) to proceed.
- **Milestones**: M0 = architecture scaffolding only (no business logic). M1-M4 group FRs by coupling/priority.
- **Sprint tracking**: `sprint/backlog.md` + `sprint/sprint.md` manage iterations.
- **State**: `.npd-status.md` tracks phase/document/sprint status; `.gate-decision.json` tracks gate decisions.
- **Install**: `npd-sw-install.sh init <target-dir>` copies the template to a new project.

### Stale README entries

The README at `npd-sw/README.md` references:
- `init-npd-sw.sh` — renamed to `npd-sw-install.sh`
- `docs/templates/` — directory was deleted (content merged into working docs)
- `report-generation.md` and `version-management.md` — both removed as unused

When editing the README, remove or update these references.
