# 如何解读评估结果

## 📊 核心指标解读

### Pass Rate (通过率)

**最重要的指标**,直接反映skill的质量。

| Pass Rate | 等级 | 状态 | 行动建议 |
|---|---|---|---|
| ≥90% | 优秀 | ✅ | 可以发布使用 |
| 80-89% | 良好 | ✅ | 可以使用,建议改进 |
| 70-79% | 合格 | ⚠️ | 需要改进后再发布 |
| <70% | 不合格 | ❌ | 需要重大改进 |

**计算方式**:
```
Pass Rate = (通过的assertion数 / 总assertion数) × 100%
```

**示例**:
- Test 1: 3/3 assertions通过 → 100%
- Test 2: 2/3 assertions通过 → 67%
- Test 3: 3/3 assertions通过 → 100%
- **总体Pass Rate**: (3+2+3)/(3+3+3) = 89%

---

### With-Skill vs Baseline对比

**证明skill价值的关键指标**。

#### 理想情况(✅)
- **Pass Rate**: with-skill > baseline (+10%以上)
- **结论**: Skill带来了明显价值
- **行动**: 可以发布

#### 正常情况(✅)
- **Pass Rate**: with-skill ≈ baseline (±5%)
- **结论**: Skill保持了原有水平
- **分析**: 检查是否有其他优势(如性能、用户体验)

#### 需警惕(⚠️)
- **Pass Rate**: with-skill < baseline
- **结论**: Skill可能有问题
- **行动**: 深入分析原因,重新设计skill

---

### Timing (执行时间)

**效率指标**,不是越快越好。

#### 可接受的性能下降
```
with-skill耗时 > baseline耗时
但 Pass Rate提升 > 10%
```
**结论**: 性能下降是可接受的trade-off

#### 需要优化
```
with-skill耗时 >> baseline耗时 (2倍以上)
且 Pass Rate提升 < 10%
```
**结论**: Skill引入了不必要的复杂度,需要优化

#### 理想情况
```
with-skill耗时 ≤ baseline耗时
且 Pass Rate提升 > 5%
```
**结论**: Skill既快又好,优秀! ✅

---

### Tokens使用量

**成本指标**,tokens越多成本越高。

#### 正常情况
```
with-skill tokens > baseline tokens
超出 < 20%
```
**结论**: 加载skill指令需要额外tokens,正常

#### 需优化
```
with-skill tokens >> baseline tokens
超出 > 50%
```
**结论**: Skill太复杂,考虑简化指令

---

## 📈 评估Viewer使用指南

### Outputs标签页

**查看每个测试的详细输出**。

#### 如何查看:
1. 点击左侧测试名称(如eval-1-start-work)
2. 查看右侧详细输出
3. 对比with-skill vs baseline
4. 在底部文本框留下反馈

#### 重点关注:
- ❌ **失败的assertion**: 为什么失败?
- ⚠️ **不完整的输出**: 缺少了什么?
- ✅ **成功的亮点**: Skill哪里做得好?

#### 留下有效反馈:
**Bad**: "不好用" ❌
**Good**: "缺少progress.md文件,建议在创建任务时生成完整三文件" ✅

---

### Benchmark标签页

**查看定量对比数据**。

#### 如何阅读:

```
Configurations:
├── with_skill
│   ├── Mean Pass Rate: 100%
│   ├── Mean Duration: 182s
│   └── Mean Tokens: 34,098
│
└── without_skill (baseline)
    ├── Mean Pass Rate: 78%
    ├── Mean Duration: 88s
    └── Mean Tokens: 31,493

Comparison:
├── Pass Rate Delta: +22%  (更好 ✅)
├── Duration Delta: +93s   (更慢 ⚠️)
└── Tokens Delta: +2,605   (更多 ⚠️)
```

**解读**:
- Pass Rate +22%: Skill显著提升了成功率 ✅
- Duration +93s: 耗时增加,但可接受(因为Pass Rate提升明显)
- Tokens +2,605: 成本增加8%,正常范围

**结论**: Skill带来了明显价值,值得使用!

---

## 🎯 常见评估场景解读

### 场景1: Pass Rate很高,但baseline也高

```
with-skill: 95%
baseline: 92%
```

**解读**:
- 任务相对简单,不加skill也能完成
- Skill带来的改进有限(+3%)
- **建议**: 考虑skill是否真的必要

### 场景2: Pass Rate低,但baseline更低

```
with-skill: 65%
baseline: 45%
```

**解读**:
- 任务有难度
- Skill带来了明显改进(+20%)
- 但绝对值还不够高
- **建议**: 继续改进skill,目标达到≥75%

### 场景3: 所有测试都失败

```
with-skill: 0%
baseline: 0%
```

**解读**:
- 测试用例可能有问题,或
- Skill完全无法工作
- **建议**: 先检查测试用例合理性,再检查skill

### 场景4: 某个测试总是失败

```
Test 1: ✅
Test 2: ✅
Test 3: ❌ (总是失败)
```

**解读**:
- Test 3覆盖的功能有问题
- **建议**: 重点分析Test 3,针对性改进

---

## 🔍 深度分析技巧

### 技巧1: 查看完整transcript

不要只看最终输出,查看完整的执行transcript:
- 每一步操作是什么?
- 在哪里卡住了?
- 有没有不必要的操作?

### 技巧2: 对比成功和失败

对比成功的测试和失败的测试:
- 成功的测试有什么共同点?
- 失败的测试有什么共同点?
- 差异在哪里?

### 技巧3: 分析token使用

看tokens用在哪里:
- 读取文件消耗多少?
- 思考推理消耗多少?
- 输出生成消耗多少?

### 技巧4: 时间分布

分析时间花在哪里:
- 哪个步骤最耗时?
- 是否有优化空间?
- 慢是skill的问题还是任务本身的复杂度?

---

## ⚠️ 常见误判

### 误判1: Pass Rate高就一定好

**不一定!** 还要看:
- 测试用例是否足够难?
- assertions是否足够严格?
- baseline表现如何?

**示例**:
```
Pass Rate: 100%
Assertions: ["输出包含'完成'"]
```
这太简单了,没有意义。

### 误判2: 慢就一定不好

**不一定!** 要看trade-off:
- Pass Rate提升显著?
- 用户体验改善明显?
- 耗时是否在可接受范围?

**示例**:
```
Pass Rate: +30%
Duration: +50%
```
如果baseline是10秒,with-skill是15秒,+5秒换来+30%的成功率,值得!

### 误判3: Tokens多用就是浪费

**不一定!** 要看产出:
- Tokens用在了正确的地方?
- 带来了更好的结果?
- 成本增加是否合理?

**示例**:
```
Tokens: +5,000
Pass Rate: +25%
```
成本增加15%,成功率提升25%,合理的投资!

---

## 📋 评估结果Checklist

完成评估后,确认:

- [ ] Pass Rate ≥ 70%
- [ ] With-skill ≥ Baseline
- [ ] 核心功能测试全部通过
- [ ] 性能在可接受范围
- [ ] 已review每个测试的详细输出
- [ ] 对不满意的地方留下了具体反馈
- [ ] 生成了benchmark.json
- [ ] 准备好提交PR(如果达标)

---

## 💡 基于评估改进Skill

### 发现问题后如何改进:

1. **分类问题**
   - 核心功能问题 → 最高优先级
   - 用户体验问题 → 中等优先级
   - 性能问题 → 低优先级

2. **定位原因**
   - 是指令不够清晰?
   - 是缺少必要的工具?
   - 是流程设计有问题?

3. **针对性改进**
   - 修改SKILL.md指令
   - 添加辅助脚本
   - 调整工作流程

4. **重新评估**
   - 创建iteration-2
   - 对比iteration-1和iteration-2
   - 验证改进效果

---

## 📚 延伸阅读

- [编写测试用例](./writing-test-cases.md)
- [评估方法论](./evaluation-methodology.md)
- [最佳实践](./best-practices.md)

---

**记住**: 评估的目的是发现问题并改进,而不是为了通过检查! 🎯