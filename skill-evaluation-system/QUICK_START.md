# 5分钟快速上手

最快速度开始评估你的skill!

## ⚡ 极速开始(如果你熟悉skill-creator)

```bash
# 1. 创建工作目录
mkdir my-skill-eval && cd my-skill-eval

# 2. 创建evals.json(3个测试用例就够了!)
cat > evals.json << 'EOF'
{
  "skill_name": "your-skill-name",
  "evals": [
    {
      "id": 1,
      "prompt": "用户会说的真实prompt 1",
      "expected_output": "预期输出描述",
      "assertions": []
    },
    {
      "id": 2,
      "prompt": "用户会说的真实prompt 2",
      "expected_output": "预期输出描述",
      "assertions": []
    },
    {
      "id": 3,
      "prompt": "用户会说的真实prompt 3",
      "expected_output": "预期输出描述",
      "assertions": []
    }
  ]
}
EOF

# 3. 启动Claude并告诉它:
# "使用skill-creator来评估这个skill,evals.json已准备好"

# 4. Claude会自动:
# - 并行运行6个子代理(3个with-skill + 3个baseline)
# - 收集timing数据
# - 生成benchmark
# - 打开可视化viewer让你review

# 5. Review后点击"Submit All Reviews",Claude会根据反馈迭代改进!
```

---

## 📝 标准流程(推荐)

### Step 1: 准备测试用例(5分钟)

创建 `evals.json` 文件:

```json
{
  "skill_name": "your-skill-name",
  "evals": [
    {
      "id": 1,
      "prompt": "一个用户实际会说的prompt",
      "expected_output": "这个测试应该产生什么输出",
      "files": [],
      "assertions": []
    }
  ]
}
```

**关键点**:
- 至少3个测试用例
- prompt要真实(用户实际表达)
- 覆盖核心功能场景

### Step 2: 运行评估(自动)

对Claude说:

> "使用skill-creator评估这个skill,evals.json在[路径]"

Claude会自动:
1. 并行启动所有测试(with-skill + baseline)
2. 实时收集数据
3. 自动grading
4. 生成可视化viewer

### Step 3: Review结果(5分钟)

浏览器自动打开viewer:

**Outputs标签**:
- 查看每个测试的详细输出
- 对比with-skill vs baseline
- 留下具体反馈

**Benchmark标签**:
- Pass rate对比
- Timing数据
- Tokens使用量

### Step 4: 迭代改进

点击"Submit All Reviews"后:
- Claude读取你的反馈
- 根据反馈改进skill
- 重新运行评估(iteration-2)
- 直到满意为止

---

## 🎯 成功标准

| 指标 | 目标 | 你的结果 |
|---|---|---|
| Pass Rate | ≥70% | ?% |
| 核心功能 | 全部通过 | ? |
| vs Baseline | 更优 | ? |

---

## 📋 测试用例模板

### 启动场景
```json
{
  "id": 1,
  "prompt": "开始/启动/初始化[功能]",
  "expected_output": "检测状态,显示信息,提供选项"
}
```

### 核心功能场景
```json
{
  "id": 2,
  "prompt": "执行[核心操作]",
  "expected_output": "完成操作,生成输出,确认结果"
}
```

### 完成/收尾场景
```json
{
  "id": 3,
  "prompt": "完成/结束/提交",
  "expected_output": "更新状态,生成总结,归档数据"
}
```

---

## 🔧 常见场景模板

### 文件处理类skill
```json
{
  "id": 1,
  "prompt": "处理这个文件: [文件路径]",
  "expected_output": "读取文件,处理内容,生成结果文件"
}
```

### 数据转换类skill
```json
{
  "id": 1,
  "prompt": "将[格式A]转换为[格式B]",
  "expected_output": "读取输入,转换格式,保存输出"
}
```

### 工作流类skill
```json
{
  "id": 1,
  "prompt": "开始[工作流程]",
  "expected_output": "初始化流程,显示步骤,等待用户确认"
}
```

---

## 💡 Pro Tips

### Tip 1: 从核心开始
不要试图测试所有功能。首次评估只用3-5个核心场景:
- 启动
- 核心操作
- 完成

### Tip 2: 使用真实prompt
从用户反馈、issue、实际使用中收集真实prompt,而不是自己编造。

### Tip 3: Baseline很重要
with-skill vs baseline的对比证明了skill的价值,不要跳过!

### Tip 4: 迭代改进
评估不是一次性的。发现问题 → 改进 → 重新评估 → 直到满意。

### Tip 5: 保留测试数据
把evals.json和benchmark.json提交到git,作为skill质量的证明。

---

## 🆘 卡住了?

### Q: 不知道写什么prompt?
A: 想象你的用户第一次使用skill会说什么。或者查看examples/目录的真实示例。

### Q: 测试失败了怎么办?
A: 很好!失败揭示了问题。在viewer中留下具体反馈,Claude会帮你改进。

### Q: Pass Rate只有60%?
A: 还没达标。重点看失败的测试,分析原因,改进后重新评估。

### Q: Claude评估太慢?
A: 测试是并行运行的。3个测试通常5-15分钟完成。可以在后台运行,先做其他事。

---

## 📚 下一步

- 阅读 [CONTRIBUTING.md](./CONTRIBUTING.md) 了解提交PR的要求
- 查看 [examples/](./examples/) 目录的完整示例
- 学习 [docs/writing-test-cases.md](./docs/writing-test-cases.md) 编写更好的测试

---

**准备好了? 开始评估你的第一个skill!** 🚀