# 系统测试用例 (ST)

> **项目名称**: {PROJECT_NAME}
> **测试阶段**: 系统测试 (ST)
> **关联 SRS**: docs/02-Requirement/SRS-template.md
> **创建日期**: {DATE}

---

## 系统测试说明

每个 ST 用例必须覆盖以下维度：
- **正常路径**: 验证预期行为
- **异常路径**: 验证错误处理
- **边界条件**: 验证边界值处理

所有 ST 用例必须可追踪至 SRS 中的 FR/NFR。

---

## ST-001: {测试用例名称}

| 属性 | 值 |
|------|-----|
| **Traceability ID** | FR-001 |
| **优先级** | 高 |
| **前置条件** | {系统状态} |
| **测试数据** | {测试数据} |

### 测试步骤

| 步骤 | 操作 | 预期结果 |
|------|------|---------|
| 1 | {Given} {初始状态} | {系统就绪} |
| 2 | {When} {执行操作} | {Then} {预期输出} |
| 3 | {When} {后续操作} | {Then} {预期输出} |

### 测试实现

```typescript
// test/st/st-001.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';

describe('ST-001: {测试用例名称}', () => {
  beforeAll(async () => {
    // 初始化测试环境
  });

  afterAll(async () => {
    // 清理测试环境
  });

  it('should {预期行为描述}', async () => {
    // Given
    // When
    // Then
  });

  it('should handle error when {异常场景}', async () => {
    // Given
    // When
    // Then
  });
});
```

---

## ST-002: {测试用例名称}

| 属性 | 值 |
|------|-----|
| **Traceability ID** | FR-002 |
| **优先级** | 中 |
| **前置条件** | TBD |

### 测试步骤

| 步骤 | 操作 | 预期结果 |
|------|------|---------|
| 1 | Given TBD | TBD |
| 2 | When TBD | Then TBD |

---

## 测试覆盖率矩阵

| FR ID | ST ID | 正常路径 | 异常路径 | 边界条件 | 状态 |
|-------|-------|---------|---------|---------|------|
| FR-001 | ST-001 | ✓ | ✓ | ✓ | pending |
| FR-002 | ST-002 | ✓ | ✗ | ✓ | pending |

---

## 测试执行记录

| 日期 | ST ID | 结果 | 备注 |
|------|-------|------|------|
| TBD | TBD | TBD | TBD |
