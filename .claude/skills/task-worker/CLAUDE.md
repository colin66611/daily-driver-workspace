[根目录](../../CLAUDE.md) > [skills](../) > **task-worker**

# Task Worker - 模块文档

## 模块职责

Task Worker 是主线任务执行官（实时文件更新版本），作为核心执行引擎，负责：
- 围绕主线任务进行深入讨论
- 实时更新文件系统记录进展
- 强制输出三阶段结构（exploring/完成/收尾），不允许悬空对话

**核心特性**:
- 实时文件更新机制
- 2-Action Rule 增强版
- 恢复机制支持
- 三阶段输出结构

---

## 入口与启动

### 触发方式

```
/task-worker
```

通常与 Daily Driver 配合使用：
```
展开 M1    # Daily Driver 调用 Task Worker 展开任务
```

### 执行流程

1. **初始化时读取状态**
   - 读取 task_plan.md
   - 读取 progress.md
   - 读取 findings.md
   - 输出当前任务状态

2. **执行过程中实时更新**
   - 每完成一个操作 → 更新 progress.md
   - 每有一个发现 → 追加到 findings.md
   - 每完成一个阶段 → 更新 task_plan.md
   - 每遇到一个错误 → 记录到错误表格

3. **2-Action Rule 增强版**
   - 每执行 2 个操作后自动保存
   - 提醒用户已保存发现

4. **任务完成时最终更新**
   - 标记任务完成
   - 创建完成记录
   - 更新今日主记录

---

## 对外接口

### 三阶段输出

#### Exploring 阶段输出

```
**【Exploring - 研究发现】**
[基于 findings.md 内容实时生成]
```

#### Completed 阶段输出

```
**【Completed - 完成情况】**
[基于 task_plan.md 和 progress.md 生成]
```

#### Closing 阶段输出

```
**【Closing - 下一步】**
[基于所有文件内容生成]
```

### 文件系统接口

Task Worker 操作 Daily Driver 创建的三文件系统：
- `task_plan.md` - 任务规格和状态
- `findings.md` - 研究发现记录
- `progress.md` - 进展日志

---

## 关键依赖与配置

### 依赖关系

Task Worker 通常与 Daily Driver 配合使用：
- Daily Driver 负责任务创建和文件夹初始化
- Task Worker 负责任务执行和实时更新

### 实时更新原则

1. **操作即保存**：每完成一个操作，立即更新相应文件
2. **发现即记录**：每有一个发现，立即追加到 findings.md
3. **进展即标记**：每有进展，立即更新 progress.md
4. **错误即登记**：每遇到错误，立即记录到错误表格

### 恢复机制

任何时候中断后，都可以从文件恢复：
```bash
# 恢复任务状态
task_plan=$(cat "${task_folder}/task_plan.md")
last_progress=$(tail -n 10 "${task_folder}/progress.md")
last_finding=$(tail -n 5 "${task_folder}/findings.md")
```

---

## 数据模型

### 文件更新模式

#### 完成操作时

```bash
echo "
### $(date '+%H:%M') - 完成 [操作类型]
- ✅ [具体完成了什么]
- 📍 新状态: [更新后的状态]" >> "${task_folder}/progress.md"
```

#### 记录发现时

```bash
echo "
### Finding N: [标题]
- **发现时间**: $(date '+%Y-%m-%d %H:%M')
- **来源**: [搜索/阅读/分析]
- **核心内容**: [详细描述]
- **关键洞察**: [为什么重要]
- **可行动项**: [下一步]" >> "${task_folder}/findings.md"
```

#### 记录错误时

```bash
echo "
### $(date '+%H:%M') - 遇到错误
- ⚠️ 错误: [错误描述]
- 🔄 尝试: [第几次尝试]
- 💡 解决方案: [如何解决]" >> "${task_folder}/progress.md"
```

---

## 测试与质量

### 核心功能验证

1. **状态读取** - 正确读取三文件系统
2. **实时更新** - 每步操作后立即更新文件
3. **2-Action Rule** - 每2个操作自动保存
4. **任务完成** - 正确标记完成并生成总结
5. **恢复机制** - 中断后能从文件恢复

### 质量保证

- 文件更新使用原子操作
- 保留完整的工作历史
- 不依赖 Context Window

---

## 常见问题 (FAQ)

### Q: Task Worker 和 Daily Driver 有什么区别？
A: Daily Driver 负责任务创建和管理，Task Worker 负责任务执行和实时更新。

### Q: 可以单独使用 Task Worker 吗？
A: 可以，但通常与 Daily Driver 配合使用以获得完整的任务管理体验。

### Q: 如果文件被意外删除怎么办？
A: 文件系统作为外部记忆，建议定期备份工作目录。

---

## 相关文件清单

```
skills/task-worker/
├── CLAUDE.md          # 本文件
└── SKILL.md           # Skill 核心定义
```

**注意**: Task Worker 没有独立的 README.md，因为它通常与 Daily Driver 配合使用，使用方式在 Daily Driver 的文档中说明。

---

## 变更记录 (Changelog)

| 日期 | 变更内容 |
|------|----------|
| 2026-03-27 | 创建模块级 CLAUDE.md |

---

*本文档由 Claude Code 自动生成。*
