# Status Check Workflow

Display current project status by scanning files and state.

## Steps

### Step 1: Scan Project Files
- Check existence of:
  - `sprint/sprint.md` — sprint plan
  - `docs/01-Concept/Charter.md` — project charter
  - `docs/01-Concept/Market_Research.md` — market research
  - `docs/01-Concept/User_Research.md` — user research
  - `docs/02-Requirement/SRS.md` — SRS
  - `sprint/backlog.md` — backlog items
  - `sprint/sprint.md` — sprint plan
  - `docs/03-Design/SAD.md` — SAD
  - `docs/03-Design/RTM.md` — RTM
  - `test/st/*.test.*` — system test cases
  - `test/ut/*.test.*` — unit test cases
  - `src/` — source code

### Step 2: Print Report
- Format:
  ```
  ## NPD-SW Workflow Status
  - **Current Phase**: {phase} - {phase_name}
  - **Current Milestone**: {milestone}
  - **Review Status**: {review_status}
  - **Completed Documents**: {list}
  - **Next Action**: {next_action}
  ```

### Step 3: Suggest Next Command
- Based on current state, recommend the next command to run
- Example: if Phase 0 just completed, suggest `/npd-requirement`

## Constraints
- Read-only — do NOT modify any files
- Report must be clear enough for user to decide next action
