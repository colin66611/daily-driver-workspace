# Skill 评估测试系统

标准化的Claude技能评估框架,让每个contributor在提交PR前都能自测技能质量。

## 🎯 目标

- **标准化测试流程** - 统一的评估方法和标准
- **自动化测试执行** - 并行运行测试用例,自动收集数据
- **可视化评估界面** - 直观对比with-skill和without-skill的表现
- **定量评估指标** - Pass rate, timing, tokens使用量

## 🚀 快速开始

### 5分钟快速测试

```bash
# 1. 创建评估工作目录
mkdir my-skill-eval && cd my-skill-eval

# 2. 创建测试用例(复制模板)
cp skill-evaluation-system/templates/evals_template.json evals.json
# 编辑evals.json,填写3-5个测试用例

# 3. 运行评估(对Claude说)
"使用skill-creator评估这个skill,evals.json在当前目录"

# 4. Claude自动执行:
# - 并行运行所有测试(with-skill + baseline)
# - 收集timing数据
# - 生成benchmark
# - 打开可视化viewer让你review
```

## 📊 评估标准

| Pass Rate | 等级 | 状态 | PR决策 |
|---|---|---|---|
| ≥90% | 优秀 | ✅ | 可以直接合并 |
| ≥80% | 良好 | ✅ | 可以合并,建议改进 |
| ≥70% | 合格 | ⚠️ | 需在PR中说明改进计划 |
| <70% | 不合格 | ❌ | **不能提交PR**,先改进 |

## 📁 目录结构

```
skill-evaluation-system/
├── QUICK_START.md           # 快速开始(本文件)
├── CONTRIBUTING.md          # Contributor必读
├── templates/               # 模板文件
│   ├── evals_template.json
│   ├── eval_metadata_template.json
│   └── grading_template.json
├── scripts/                 # 脚本工具
│   └── run_evaluation.sh
├── docs/                    # 详细文档
│   ├── writing-test-cases.md
│   └── interpreting-results.md
└── examples/                # 完整示例
    └── daily-driver-eval/
```

## 📝 提交PR前必做

详见 [CONTRIBUTING.md](./CONTRIBUTING.md)

**最低要求**:
- ✅ 完成至少3个核心测试用例评估
- ✅ Pass Rate ≥ 70%
- ✅ 提交evals.json和benchmark.json
- ✅ 在PR描述中说明评估结果

## 📚 详细文档

- [如何编写测试用例](./docs/writing-test-cases.md) - 真实性、覆盖度、可验证性
- [如何解读评估结果](./docs/interpreting-results.md) - Pass Rate、对比baseline、性能分析
- [完整示例](./examples/daily-driver-eval/) - daily-driver skill的评估案例

## 💡 核心价值

### 为什么需要评估?

1. **质量保证** - 确保skill功能正常,不会break用户工作流
2. **持续改进** - 定量指标帮助识别问题和改进方向
3. **价值证明** - Baseline对比证明skill带来的价值
4. **降低风险** - PR前自测,避免合并有问题的代码

### 评估流程

```
编写测试用例(3-5个核心场景)
    ↓
运行评估(自动并行执行)
    ↓
Review结果(浏览器可视化)
    ↓
达标? (Pass Rate ≥ 70%)
    ↓ Yes
提交PR(附评估结果)
    ↓ No
改进skill,重新评估
```

## 🔧 使用场景

### 场景1: 新建skill

1. 开发完skill核心功能
2. 创建3个测试用例(启动、核心操作、完成)
3. 运行评估验证功能
4. Pass Rate ≥ 70%后提交PR

### 场景2: 修改现有skill

1. 修改skill代码
2. 运行已有测试用例
3. 确认没有regression(Pass Rate未下降)
4. 如有新功能,添加新测试用例
5. 提交PR

### 场景3: 优化skill

1. 运行评估获取baseline
2. 优化skill代码
3. 重新评估对比改进效果
4. Pass Rate提升 → 合并

## 🎯 示例结果

查看 [examples/daily-driver-eval/](./examples/daily-driver-eval/) 的真实评估:

```
测试用例: 3个核心场景
Pass Rate: 100% (with-skill) vs 78% (baseline)
提升: +22%
结论: Skill显著提升了成功率 ✅
```

## 🤝 贡献

欢迎贡献:
- 更好的测试用例模板
- 新的评估维度
- 改进文档和示例
- 分享你的评估经验

---

**开始评估你的第一个skill!** 🚀

有问题? 查看 [CONTRIBUTING.md](./CONTRIBUTING.md) 或 [完整示例](./examples/daily-driver-eval/)