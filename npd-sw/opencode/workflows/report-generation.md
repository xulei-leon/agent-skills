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
# M{n} 测试报告

- **日期**: YYYY-MM-DD
- **UT 总数**: 12, 通过: 12, 失败: 0 (通过率: 100.0%)
- **ST 总数**: 5, 通过: 5, 失败: 0 (通过率: 100.0%)
- **覆盖率**: 85.0%
- **已知问题**: 无
```

### Step 2: Generate Traceability Matrix
- Input: `TraceItem[]`
- Output: Markdown table

```markdown
| FR ID | 需求描述 | 涉及 US | 涉及 ST | 状态 |
|-------|---------|---------|---------|------|
| FR-001 | 用户登录 | US-M1-01 | ST-001 | completed |
```

## Usage

```markdown
1. Test report: `generateTestReport({ milestone: "M1", utPassed: 12, ... })`
2. RTM: `generateTraceabilityMatrix([{ frId: "FR-001", ... }])`
```
