# 🧠 Daily Driver Workspace（每日驾驶座工作区）

> **让 AI Agent 拥有长期记忆** — 一个基于文件系统的工作区，让 AI 编程助手（Claude Code、Cursor、OpenCode）自动记住昨天的任务、管理灵感、追踪进度。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Ready-d4a574)](https://claude.ai/code)
[![AI Agents](https://img.shields.io/badge/AI_Agents-Claude_Cursor_OpenCode-7c3aed)](https://github.com/topics/ai-agents)
[![Knowledge Management](https://img.shields.io/badge/Knowledge_Management-第二大脑-00b4d8)](https://github.com/topics/knowledge-management)

---

## 🔗 Language / 语言

[English](README.md) | [中文](README_zh.md)

---

## 痛点

你的 AI 编程助手很聪明，但**每次对话结束后就忘得一干二净**。你需要反复交代背景、重复解释任务、丢失灵感火花。上下文窗口就像金鱼的记忆。

## 解决方案

**Daily Driver Workspace** 把文件系统变成 AI 的长期记忆。不需要数据库、不需要云端同步——纯文本文件，任何 AI Agent 都能读写。

### 30秒演示

<video src="https://github.com/user-attachments/assets/571957493-4666de1b-db6d-44e1-8fb6-146818a24a0c" autoplay loop muted playsinline width="100%"></video>

| 步骤 | 你说 | Agent 动作 |
|------|------|-----------|
| **① 启动** | `开启今天的工作` | 自动检测昨天未完成任务 |
| **② 回顾** | *(自动)* | 显示待办任务 + 想法停车场 |
| **③ 选择** | `处理学习新技术，延续M2` | 你选择今天要做的事 |
| **④ 创建** | *(自动)* | 生成任务文件夹 + 三文件系统 |
| **⑤ 锁定** | *(自动)* | `✅ 今日工作已锁定` — 开始干活 |

---

## ✨ 核心功能

| 功能 | 说明 |
|------|------|
| 🔍 **昨日任务检测** | 自动读取上次未完成的 M1/M2/M3 任务 |
| 🅿️ **想法停车场** | 灵感集中管理，随时取用，不再遗忘 |
| 🗂️ **三文件系统** | 每个任务标配 `task_plan.md` + `progress.md` + `findings.md` |
| ✅ **5层检查点** | 从需求澄清到边界检查，防止 AI 跑偏 |
| 🪟 **多窗口并行** | 多个终端同时干活，文件保证状态一致 |
| 📦 **零依赖** | 纯 bash + markdown，无数据库、无 API、无需云端 |

---

## 🆚 方案对比

| | Obsidian/Notion | ChatGPT 记忆 | **Daily Driver** |
|---|---|---|---|
| **自动记录** | ❌ 手动 | ⚠️ 部分 | ✅ 全自动 |
| **任务连续性** | ❌ 手动管理 | ❌ 新对话就丢 | ✅ 自动接续 |
| **离线可用** | ✅ 是 | ❌ 仅云端 | ✅ 是 |
| **AI 原生** | ❌ 否 | ⚠️ 仅限聊天 | ✅ 文件驱动 |
| **平台锁定** | ⚠️ 格式绑定 | 🔒 平台锁定 | 📄 纯 markdown |

---

## 📁 文件结构

```
你的知识库/
├── CLAUDE.md                 # 项目指导和长期记忆
├── work/                     # 工作归档（长期）
├── life/                     # 生活归档（长期）
├── learning/                 # 学习归档（长期）
└── others/
    ├── daily/                # 每日工作区（活跃任务）
    │   ├── _Idea-Parking-Lot.md
    │   └── 2026-03-30/       # 按日期组织
    │       ├── 2026-03-30.md
    │       └── task_M1_学习技术/
    │           ├── task_plan.md
    │           ├── progress.md
    │           └── findings.md
    └── demo/
```

### 工作流：活跃 → 归档

| 阶段 | 位置 | 说明 |
|------|------|------|
| **创建** | `daily/YYYY-MM-DD/` | 所有任务默认在此创建 |
| **进行中** | `daily/`（实时更新） | 自动记录 progress/findings |
| **完成** | 留在 `daily/` 或归档 | 只有有复用价值的内容才归档 |
| **归档** | `work/` / `life/` / `learning/` | Agent 自动分类到长期存储 |

---

## 🚀 快速开始

### 方式一：Agent 自动安装（推荐）

```bash
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace
# 对 Agent 说："读取 AGENT_SETUP.md 并完成安装"
```

### 方式二：手动安装

```bash
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace
./install.sh
```

### 方式三：仅复制技能

```bash
cp -r .claude/skills/* ~/.claude/skills/
mkdir -p ~/my-notes/{learning,life,work,others/daily}
```

---

## 🎯 使用方法

### 启动一天的工作
```
你：开启今天的工作

Agent：📋 昨天的未完成任务：
       • M1: [任务名] (⏸ 进行中)
       • M2: [任务名] (⏸ 进行中)
       🅿️ 想法停车场：
       • 学习新技术
       • 整理读书笔记
       🎯 今天你打算做些什么？
```

### 展开具体任务
```
你：展开 M1

Agent：[读取 task_plan.md]
       🔒 规格已锁定
       [开始执行任务]
       [每2个操作自动保存发现到 findings.md]
       [更新 progress.md]
```

### 结束一天的工作
```
你：结束今天的工作

Agent：[总结完成的任务 🎉]
       [记录未完成项]
       [询问是否归档]
```

---

## 🏗️ 系统架构

```
用户输入
  ↓
【检查点1】检测昨天未完成任务
  ↓
【检查点2】读取想法停车场
  ↓
【检查点3】确认今日任务
  ↓
【检查点4】锁定任务规格
  ↓
创建任务文件夹和文件
  ↓
【检查点5】执行时边界检查
  ↓
任务完成 → 归档
```

---

## 🔧 系统要求

| 系统 | 要求 | 说明 |
|------|------|------|
| **macOS/Linux** | Claude Code CLI | `npm install -g @anthropic/claude-code` |
| **Windows** | Git Bash + Node.js 18+ | [git-scm.com](https://git-scm.com/download/win) + [nodejs.org](https://nodejs.org/) |

兼容：**Claude Code**、**Cursor**、**OpenCode**，以及任何能读写文件的 AI Agent。

---

## 📚 文档

- [AGENT_SETUP.md](AGENT_SETUP.md) — 给 AI 看的安装指南
- [技能评估系统](skill-evaluation-system/) — 评估和提升你的 Agent 技能

---

## 🤝 贡献

欢迎提交 PR！详见 [CONTRIBUTING.md](.github/CONTRIBUTING.md)。

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'feat: 添加新功能'`)
4. 推送分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

---

## 📄 许可证

[MIT](LICENSE) © Colin Song

---

## 🙏 致谢

- **三文件系统**思想受到 [planning-with-files](https://github.com/OthmanAdi/planning-with-files) 的启发
- 为 [Claude Code](https://claude.ai/code) 社区而建

---

**⭐ 如果这个项目对你有帮助，请给个 Star！** 这是持续开发的最大动力。
