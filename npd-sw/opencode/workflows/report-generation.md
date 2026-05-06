# Report Generation Workflow

Generate milestone test reports and traceability matrices in Markdown.

## Data Types

```typescript
interface TestReport {
  milestone: string;
  date: string;
  utTotal: number;
  utPassed: number;
  utFailed: number;
  stTotal: number;
  stPassed: number;
  stFailed: number;
  coverage?: number;
  knownIssues: string[];
}

interface TraceItem {
  frId: string;
  description: string;
  userStories: string[];
  stCases: string[];
  status: 'pending' | 'in_progress' | 'completed';
}
```

## Steps

### Step 1: Generate Test Report
- Input: `TestReport` data
- Calculate pass rates: `(passed / total * 100).toFixed(1)`
- Output format:

```markdown
# M{n} Test Report

- **Date**: YYYY-MM-DD
- **UT Total**: 12, Passed: 12, Failed: 0 (Pass Rate: 100.0%)
- **ST Total**: 5, Passed: 5, Failed: 0 (Pass Rate: 100.0%)
- **Coverage**: 85.0%
- **Known Issues**: None
```

### Step 2: Generate Traceability Matrix
- Input: `TraceItem[]`
- Output: Markdown table

```markdown
| FR ID | Requirement Description | Related US | Related ST | Status |
|-------|------------------------|------------|------------|--------|
| FR-001 | User Login | US-M1-01 | ST-001 | completed |
```

## Usage

```markdown
1. Test report: `generateTestReport({ milestone: "M1", utPassed: 12, ... })`
2. RTM: `generateTraceabilityMatrix([{ frId: "FR-001", ... }])`
```
