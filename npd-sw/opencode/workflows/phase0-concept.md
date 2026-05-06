# Concept Phase Workflow

Complete Phase 0: research → approve → charter → approve.

## Steps

### Step 1: Market Research
- Use the `market-analysis` skill
- Output: `docs/01-Concept/Market_Research.md`
- Include: TAM/SAM/SOM, competitor analysis, SWOT, user personas, business model

### Step 2: User Research
- Use the `market-analysis` skill
- Output: `docs/01-Concept/User_Research.md`
- Include: research methods, user roles, journey map, pain points, priority matrix

### Step 3: Output Research Review Signal
- Print `[Research Review]` with checklist:
  - Market Research
  - User Research
- Wait for user reply: `Research Approved` to proceed, or modification requests

### Step 4: Create Charter
- Use the `market-analysis` skill
- Input: user's project description + research findings from Step 1-2
- Output: `docs/01-Concept/Charter.md`
- Set `Version: 1.0.0` in header
- Include: project background, scope, milestones, roles, tech stack, budget, risks

### Step 5: Output Charter Review Signal
- Print `[Charter Review]` with checklist:
  - Charter
- Wait for user reply: `Charter Approved` to complete Phase 0

## Exit Criteria
- Market Research and User Research completed and approved
- Charter created and approved
- Each document has `Version: x.y.z` header
- User confirms with `Charter Approved`
