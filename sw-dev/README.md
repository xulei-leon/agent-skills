# SW-DEV — Software Development Commands & Skills

**SW-DEV** is a supplementary extension pack for the [npd-sw](../npd-sw/) template. It adds software-development-focused commands and skills without introducing its own lifecycle or workflow infrastructure.

## Design

- **No workflows** — commands are self-contained or reference npd-sw workflows
- **No docs/sprint/test directories** — shared with npd-sw
- **Plugs into** an existing npd-sw project via `install.sh`

## Commands

| Command | Purpose | Skill Used |
|---------|---------|------------|
| `/swd-debug` | Structured bug root cause analysis | `debug-analyst` |
| `/swd-review` | Code review with security/performance checks | `code-reviewer` |
| `/swd-refactor` | Safe incremental refactoring | `refactoring-analyst` |
| `/swd-arch` | Architecture review and design | `architect` |
| `/swd-test-design` | Advanced test case design with mock strategies | `testcase-designer` |

## Installation

```bash
# Install into an existing npd-sw project
./sw-dev/install.sh /path/to/my-project
```

This copies commands and skills into the target project's `.opencode/` directory, coexisting with existing npd-sw files.
