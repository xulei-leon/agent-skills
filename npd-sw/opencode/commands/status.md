# /status

## Goal
Display current CMM V-Model workflow status.

## Instructions

### Step 1: Read State
- Use the `state_manager` skill to read `state.json`

### Step 2: Scan Project Files
- Check existence and completeness of:
  - `state.json` — workflow state
  - `docs/01-Concept/Charter.md` — project charter
  - `docs/01-Concept/Market_Research.md` — market research
  - `docs/02-Requirement/SRS.md` — SRS
  - `docs/02-Requirement/user-stories.md` — US index
  - `docs/02-Requirement/User-Story/M*.md` — milestone specs
  - `docs/03-Design/SAD.md` — SAD
  - `docs/03-Design/RTM.md` — RTM
  - `test/st/*.test.*` — system test cases
  - `test/ut/*.test.*` — unit test cases
  - `src/` — source code

### Step 3: Print Report
- Format:
  ```
  ## CMM 工作流状态
  - **当前阶段**: {phase} - {phase_name}
  - **当前里程碑**: {milestone}
  - **评审状态**: {review_status}
  - **已完成文档**: {list}
  - **待办**: {next_action}
  ```

### Step 4: Suggest Next Command
- Based on current state, recommend the next command to run

## Constraints
- Read-only — do NOT modify any files
- Report must be clear enough for user to decide next action
