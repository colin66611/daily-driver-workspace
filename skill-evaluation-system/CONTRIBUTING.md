# 提交PR前必读 - Skill评估流程

## ⚠️ 强制要求

**所有skill相关的PR必须包含评估测试结果**

---

## ✅ 自测Checklist

### 准备阶段(10分钟)

- [ ] 1. 创建评估工作目录
  ```bash
  mkdir my-skill-eval
  ```

- [ ] 2. 编写测试用JSON(至少3个)
  ```bash
  cp skill-evaluation-system/templates/evals_template.json my-skill-eval/evals.json
  vim my-skill-eval/evals.json  # 编辑测试用例
  ```

- [ ] 3. 确认测试用例合理
  - 使用用户真实表达方式
  - 覆盖核心功能场景
  - Assertions可以客观验证

---

### 执行阶段(5-30分钟,自动运行)

- [ ] 4. 运行评估测试
  ```bash
  # 对Claude说:
  "使用skill-creator评估这个skill,evals.json在my-skill-eval/"
  ```

  **Claude自动执行**:
  - 并行运行所有测试(with-skill + baseline)
  - 收集timing和tokens数据
  - 自动grading
  - 打开可视化viewer

- [ ] 5. Review评估结果
  - 在浏览器viewer中查看每个测试详情
  - 对不满意的地方留下反馈
  - 点击"Submit All Reviews"

---

### 提交阶段

- [ ] 6. 检查核心指标
  - **Pass Rate**: ≥70% (最低标准)
  - **With-skill vs Baseline**: skill应该优于baseline
  - **核心功能**: 所有核心测试通过

- [ ] 7. 准备提交文件
  ```bash
  # PR必须包含:
  - my-skill-eval/evals.json        # 测试用例
  - my-skill-eval/benchmark.json    # 评估结果
  - my-skill-eval/iteration-1/      # 详细数据(可选)
  ```

- [ ] 8. 更新PR描述
  ```markdown
  ## Skill评估结果

  - Pass Rate: XX% (目标≥70%)
  - 测试用例: X个核心场景
  - 对比baseline: with-skill XX% vs baseline XX%

  详细结果见: my-skill-eval/benchmark.json
  ```

---

## 📊 Pass Rate标准

| 等级 | Pass Rate | 状态 | PR决策 |
|---|---|---|---|
| 优秀 | ≥90% | ✅ | 可以直接合并 |
| 良好 | ≥80% | ✅ | 可以合并,建议改进 |
| 合格 | ≥70% | ⚠️ | 需在PR中说明改进计划 |
| 不合格 | <70% | ❌ | **不能提交PR**,先改进skill |

---

## 🎯 测试用例模板

### 最小化测试(3个场景)

```json
{
  "skill_name": "your-skill-name",
  "evals": [
    {
      "id": 1,
      "prompt": "启动/开始[功能]",
      "expected_output": "初始化成功,显示状态",
      "assertions": [
        {"name": "状态检测", "check": "检测当前状态"},
        {"name": "信息显示", "check": "显示相关信息"}
      ]
    },
    {
      "id": 2,
      "prompt": "执行核心操作",
      "expected_output": "操作成功完成",
      "assertions": [
        {"name": "操作执行", "check": "执行核心功能"},
        {"name": "输出生成", "check": "生成预期输出"}
      ]
    },
    {
      "id": 3,
      "prompt": "完成/结束",
      "expected_output": "清理资源,保存状态",
      "assertions": [
        {"name": "状态更新", "check": "更新完成状态"},
        {"name": "资源清理", "check": "正确清理资源"}
      ]
    }
  ]
}
```

---

## ⚠️ 常见问题

### Q: 测试失败了怎么办?

**A**: 根据失败类型处理:
- **核心功能失败** → **必须修复后才能提交PR**
- **次要功能失败** → 在PR中说明,可以后续改进
- **边界场景失败** → 视重要性决定

### Q: Pass Rate刚好70%可以提交吗?

**A**: 可以,但需要:
1. 在PR中明确说明当前状态
2. 列出改进计划和优先级
3. 承诺在后续PR中达到≥80%

### Q: Baseline测试重要吗?

**A**: **非常重要!** Baseline对比证明skill的价值:
- with-skill > baseline → skill有价值 ✅
- with-skill ≈ baseline → skill可能不需要 ⚠️
- with-skill < baseline → skill有问题 ❌

---

## 📝 PR描述模板

```markdown
## Skill评估结果

### 测试概况
- **测试用例**: 3个核心场景
- **Pass Rate**: XX% (with-skill) vs XX% (baseline)
- **对比**: with-skill优于baseline +XX%

### 详细结果

| 测试ID | 场景 | with-skill | baseline | 状态 |
|---|---|---|---|---|
| 1 | 启动 | X/X | X/X | ✅/⚠️ |
| 2 | 核心操作 | X/X | X/X | ✅/⚠️ |
| 3 | 完成 | X/X | X/X | ✅/⚠️ |

### 评估文件
- `my-skill-eval/evals.json`: 测试用例定义
- `my-skill-eval/benchmark.json`: 完整评估数据

### 待改进项(如果有)
- [ ] 改进项1
- [ ] 改进项2

---

## Checklist
- [x] 完成自测(≥70%)
- [x] 提交评估文件
- [x] PR描述包含评估结果
- [x] 核心功能通过测试
```

---

## 🔗 相关文档

- [快速开始](./README.md) - 5分钟上手
- [编写测试用例](./docs/writing-test-cases.md) - 最佳实践
- [解读评估结果](./docs/interpreting-results.md) - 数据分析
- [完整示例](./examples/daily-driver-eval/) - 真实案例

---

**记住**: 评估不是为了卡PR,而是为了确保skill质量! 🎯