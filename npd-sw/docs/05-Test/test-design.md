# 测试设计方案

> **项目名称**: {PROJECT_NAME}
> **版本**: 1.0.0
> **编制日期**: {DATE}
> **关联**: docs/05-Test/test-strategy.md, docs/02-Requirement/SRS.md

---

## 1. 测试架构

```
┌──────────────────────────────────────────────────────┐
│                  测试执行层                            │
│  test/ut/ (单元测试)   test/st/ (系统测试)             │
├──────────────────────────────────────────────────────┤
│                  测试工具层                            │
│  TBD (Jest / Vitest / Mocha / Pytest)                │
├──────────────────────────────────────────────────────┤
│                  测试基础设施                          │
│  test/fixtures/ (测试数据)  test/results/ (结果)       │
└──────────────────────────────────────────────────────┘
```

---

## 2. 单元测试设计

### 2.1 测试范围

- 每个模块/函数的独立逻辑
- 边界条件、输入验证、异常路径

### 2.2 设计模板

```typescript
describe('模块名称', () => {
  describe('正常路径', () => {
    it('应返回预期结果', () => { /* Given-When-Then */ });
  });
  describe('异常路径', () => {
    it('应抛出错误', () => { /* Given-When-Then */ });
  });
  describe('边界条件', () => {
    it('应正确处理边界值', () => { /* Given-When-Then */ });
  });
});
```

---

## 3. 系统测试设计

### 3.1 测试范围

- 端到端业务流程
- 每个 ST 用例对应一个 FR 需求

### 3.2 设计模板

```
ST-NNN: {测试名称}
├── Traceability ID: FR-XXX
├── 前置条件: {系统状态}
├── 数据准备: {测试数据}
├── 测试步骤:
│   └── 1. Given → When → Then
│   └── 2. Given → When → Then
└── 预期结果: {最终状态验证}
```

---

## 4. 测试数据管理

### 4.1 工厂模式

```typescript
// test/fixtures/factory.ts
export function createTestUser(overrides: Partial<User>) {
  return { id: uuid(), name: 'test', role: 'user', ...overrides };
}
```

### 4.2 Mock 策略

- 外部 API：使用 nock / msw
- 数据库：使用 in-memory 或 test container
- 时间依赖：使用 fake timers

---

## 5. 测试报告

测试结果输出到 `test/results/`：

```markdown
# M{n} 测试报告

- 日期: YYYY-MM-DD
- UT: XX/XX 通过 (100%)
- ST: XX/XX 通过 (100%)
- 覆盖率: XX%
- 已知问题: 无 / [问题列表]
```

---

## 6. 变更历史

| 版本 | 日期 | 作者 | 变更描述 |
|------|------|------|---------|
| 1.0.0 | {DATE} | NPD-SW Agent | 初始版本 |
