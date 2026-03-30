# CLAUDE.md

这是你的个人知识库，使用 Daily Driver 工作流管理。

## 项目结构

```
.
├── CLAUDE.md                 # 本文件 - 项目指导和长期记忆
├── learning/                 # 学习相关内容
│   └── CLAUDE.md             # 学习模块指导
├── life/                     # 生活相关内容
│   └── CLAUDE.md             # 生活模块指导
├── work/                     # 工作相关内容
│   └── CLAUDE.md             # 工作模块指导
└── others/                   # 其他内容
    ├── CLAUDE.md             # 其他模块指导
    ├── daily/                # 每日工作区
    │   ├── _Idea-Parking-Lot.md    # 想法停车场
    │   ├── _QuickStart-Guide.md    # 快速上手指南
    │   └── YYYY-MM-DD/       # 按日期组织的每日记录
    │       ├── YYYY-MM-DD.md # 每日总结
    │       └── task_M{数字}_{任务名}/  # 任务目录
    │           ├── task_plan.md    # 任务计划
    │           ├── progress.md     # 进展日志
    │           └── findings.md     # 研究发现
    └── demo/                 # 演示和测试
```

## Daily Driver 使用

### 启动一天
```
你：开启今天的工作
Agent：今天的能量状态如何？[高 / 中 / 低]
你：中
Agent：[显示想法停车场] → [确认任务] → [创建文件夹]
```

### 展开任务
```
你：展开 M1
Agent：[读取 task_plan.md] → [开始执行] → [实时更新文件]
```

### 记录发现
在执行过程中，Agent 会自动将发现记录到 `findings.md`

### 完成任务
```
你：完成
Agent：[更新 task_plan.md 状态] → [生成总结]
```

### 结束一天
```
你：结束今天的工作
Agent：[总结今日完成] → [记录未完成] → [询问归档]
```

## 文件命名规范

### 日期目录
- 格式：`YYYY-MM-DD/`
- 示例：`2026-03-30/`

### 任务目录
- 格式：`task_M{数字}_{任务简名}/`
- 示例：`task_M1_DailyDriver开源/`
- 规则：
  - M1, M2, M3... 表示主线任务
  - 任务简名使用英文或拼音，避免空格

### 任务文件
每个任务目录必须包含：
- `task_plan.md` - 任务目标、交付物、完成标准
- `progress.md` - 执行日志和时间线
- `findings.md` - 研究发现和参考资料

## 长期记忆

<!-- 在这里记录需要长期保存的信息 -->

### 项目偏好
- 首选编辑器：Obsidian / VS Code
- 任务管理：Daily Driver 工作流
- 归档策略：每月归档到 `others/daily/archive/`

### 常用链接
<!-- 添加你常用的链接 -->

### 待探索
<!-- 记录想尝试的新工具或方法 -->

---

**最后更新**: 2026-03-30
