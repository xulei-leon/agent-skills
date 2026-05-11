# SW-DEV — Software Development Commands & Skills

**SW-DEV** is a standalone pack of software-development commands and skills. It can be installed into projects derived from [npd-sw](../npd-sw/) or any project that already exposes an `.opencode/` directory, but its commands are designed to execute independently rather than delegating to phase workflows.

## Design

- **No workflows** — each command is directly executable and keeps its execution logic in the paired skill
- **Project-convention first** — commands should follow the target project's existing layout, tooling, and review process instead of assuming npd-sw lifecycle files
- **Coexists cleanly** — installation copies `swd-*` commands and their paired skills into an existing `.opencode/` directory without requiring sw-dev-specific state files

## Commands

| Command | Purpose | Skill Used |
|---------|---------|------------|
| `/swd-debug` | Structured bug root cause analysis | `swd-debug-analyst` |
| `/swd-fix` | Apply minimal verified fix (TDD for bugs) | `swd-fixer` |
| `/swd-review` | Code review with security/performance checks | `swd-code-reviewer` |
| `/swd-refactor` | Safe incremental refactoring | `swd-refactoring-analyst` |
| `/swd-arch` | Architecture review and design | `swd-architect` |
| `/swd-test-design` | Advanced test case design with mock strategies | `swd-testcase-designer` |
| `/swd-test-run` | Run tests and diagnose failures | `swd-test-runner` |

## Installation

```bash
# Install into a project that already has an .opencode/ directory
./sw-dev/install.sh /path/to/my-project
```

This copies commands and skills into the target project's `.opencode/` directory. SW-DEV can coexist with npd-sw files, but its commands do not depend on npd-sw workflows, phase gates, or sprint documents.
