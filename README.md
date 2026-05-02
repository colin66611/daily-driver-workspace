# 🧠 Daily Driver Workspace

> **Make your AI Agent remember everything.** A file-based workspace that gives AI coding agents (Claude Code, Cursor, OpenCode) persistent memory — automatically resume yesterday's tasks, manage your ideas, and track progress across sessions.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/colin66611/daily-driver-workspace?style=social)](https://github.com/colin66611/daily-driver-workspace/stargazers)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Ready-d4a574)](https://claude.ai/code)
[![AI Agents](https://img.shields.io/badge/AI_Agents-Claude_Cursor_OpenCode-7c3aed)](https://github.com/topics/ai-agents)
[![Knowledge Management](https://img.shields.io/badge/Knowledge_Management-Second_Brain-00b4d8)](https://github.com/topics/knowledge-management)

---

## 🌐 Language / 语言

[English](#-daily-driver-workspace) | [中文](#-中文说明)

---

## The Problem

Your AI coding assistant is brilliant — but it **forgets everything between sessions**. You repeat context, re-explain tasks, lose track of ideas. The context window is a goldfish memory.

## The Solution

**Daily Driver Workspace** turns your file system into the AI's long-term memory. No databases, no cloud sync — just plain text files that any AI agent can read and write.

### 30-Second Demo

<video src="https://github.com/user-attachments/assets/571957493-4666de1b-db6d-44e1-8fb6-146818a24a0c" autoplay loop muted playsinline width="100%"></video>

| Step | You Say | Agent Does |
|------|---------|------------|
| **① Start** | `开启今天的工作` | Detects yesterday's unfinished tasks |
| **② Review** | *(auto)* | Shows pending tasks + Idea Parking Lot |
| **③ Choose** | `处理学习新技术，延续M2` | You pick what to work on today |
| **④ Create** | *(auto)* | Generates task folders + 3-file system |
| **⑤ Lock** | *(auto)* | `✅ 今日工作已锁定` — ready to go |

---

## ✨ Core Features

| Feature | Description |
|---------|-------------|
| 🔍 **Yesterday Detection** | Auto-reads unfinished M1/M2/M3 tasks from previous sessions |
| 🅿️ **Idea Parking Lot** | Centralized idea inbox — never lose a spark again |
| 🗂️ **3-File System** | Every task gets `task_plan.md` + `progress.md` + `findings.md` |
| ✅ **5-Stage Checkpoints** | From requirement clarification to boundary checks — prevents AI drift |
| 🪟 **Multi-Window Parallel** | Run multiple terminals simultaneously, files keep state consistent |
| 📦 **Zero Dependencies** | Pure bash + markdown files. No DB, no API, no cloud needed |

---

## 🆚 How It Compares

| | Obsidian/Notion | ChatGPT Memory | **Daily Driver** |
|---|---|---|---|
| **Auto-capture** | ❌ Manual | ⚠️ Partial | ✅ Full auto |
| **Task continuity** | ❌ Manual | ❌ Lost on new chat | ✅ Auto-resume |
| **Works offline** | ✅ Yes | ❌ Cloud only | ✅ Yes |
| **AI-native** | ❌ No | ⚠️ Chat-only | ✅ File-based |
| **Vendor lock-in** | ⚠️ Format-specific | 🔒 Platform locked | 📄 Plain markdown |

---

## 📁 File Structure

```
your-knowledge-base/
├── CLAUDE.md                 # Project guidance & long-term memory
├── work/                     # Work archive (long-term)
├── life/                     # Life archive (long-term)
├── learning/                 # Learning archive (long-term)
└── others/
    ├── daily/                # Daily workspace (active tasks)
    │   ├── _Idea-Parking-Lot.md
    │   └── 2026-03-30/       # Date-organized
    │       ├── 2026-03-30.md
    │       └── task_M1_learn-tech/
    │           ├── task_plan.md
    │           ├── progress.md
    │           └── findings.md
    └── demo/
```

### Workflow: Active → Archive

| Phase | Location | Description |
|-------|----------|-------------|
| **Create** | `daily/YYYY-MM-DD/` | All tasks start here |
| **Active** | `daily/` (real-time) | Auto-records progress/findings |
| **Done** | Stay in `daily/` or archive | Only archive content with reuse value |
| **Archive** | `work/` / `life/` / `learning/` | Agent auto-classifies to long-term storage |

---

## 🚀 Quick Start

### Option A: Agent Auto-Install (Recommended)

```bash
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace
# Tell your agent: "Read AGENT_SETUP.md and complete the installation"
```

### Option B: Manual Install

```bash
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace
./install.sh
```

### Option C: Copy Skills Only

```bash
cp -r .claude/skills/* ~/.claude/skills/
mkdir -p ~/my-notes/{learning,life,work,others/daily}
```

---

## 🎯 Usage

### Start Your Day
```
You: 开启今天的工作

Agent: 📋 昨天的未完成任务：
       • M1: [task name] (⏸ In Progress)
       • M2: [task name] (⏸ In Progress)
       🅿️ Idea Parking Lot:
       • Learn new tech
       • Organize reading notes
       🎯 What would you like to work on today?
```

### Expand a Task
```
You: 展开 M1

Agent: [Reads task_plan.md]
       🔒 Specification locked
       [Starts execution]
       [Auto-saves findings every 2 operations]
       [Updates progress.md]
```

### End Your Day
```
You: 结束今天的工作

Agent: [Summarizes completed tasks 🎉]
       [Records unfinished items]
       [Asks about archiving]
```

---

## 🏗️ Architecture

```
User Input
  ↓
[Checkpoint 1] Detect yesterday's unfinished tasks
  ↓
[Checkpoint 2] Read Idea Parking Lot
  ↓
[Checkpoint 3] Confirm today's tasks
  ↓
[Checkpoint 4] Lock task specifications
  ↓
Create task folders and files
  ↓
[Checkpoint 5] Boundary checks during execution
  ↓
Task complete → Archive
```

---

## 🔧 Requirements

| OS | Requirement | Details |
|----|-------------|---------|
| **macOS/Linux** | Claude Code CLI | `npm install -g @anthropic/claude-code` |
| **Windows** | Git Bash + Node.js 18+ | [git-scm.com](https://git-scm.com/download/win) + [nodejs.org](https://nodejs.org/) |

Works with: **Claude Code**, **Cursor**, **OpenCode**, and any AI agent that can read/write files.

---

## 📚 Documentation

- [AGENT_SETUP.md](AGENT_SETUP.md) — AI-readable installation guide
- [Skill Evaluation System](skill-evaluation-system/) — Evaluate and improve your agent skills

---

## 🤝 Contributing

PRs welcome! See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

[MIT](LICENSE) © Colin Song

---

## 🙏 Acknowledgments

- **3-File System** inspired by [planning-with-files](https://github.com/OthmanAdi/planning-with-files)
- Built for [Claude Code](https://claude.ai/code) community

---

**⭐ Star this repo if it helps you!** It motivates continued development.

---

## 🇨🇳 中文说明

> 你的 AI 助手有「长期记忆」吗？
>
> 你不需要记住昨天聊到哪，不用整理笔记，不用写文档——
> 只需说"开启工作"，Agent 自动唤醒昨日任务、呈现今日选项、实时记录每一步。
>
> **文件是你的外脑，Agent 是你的副驾。你专注决策，剩下的交给 Daily Driver。**

### 核心亮点

- 🔍 **昨日任务自动检测** — 打开会话，自动显示昨天没干完的活
- 🅿️ **想法停车场** — 所有灵感集中管理，随时取用，不再遗忘
- 🗂️ **三文件系统** — 每个任务标配 plan/progress/findings，完整生命周期记录
- ✅ **5层检查点** — 从需求澄清到边界检查，防止 AI 跑偏
- 🪟 **多窗口并行** — 多个终端同时干活，文件保证状态一致
- 📦 **零依赖** — 纯 bash + markdown，无数据库、无 API、无需云端

### 和 Obsidian/Notion 的区别

Obsidian/Notion 是你**手动整理**的笔记，Daily Driver 是 **AI 自动记录**的工作日志。你只管说话，Agent 负责记账。

### 快速开始

```bash
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace
# 对 Agent 说："读取 AGENT_SETUP.md 并完成安装"
```

**⭐ 如果这个项目对你有帮助，请给个 Star！**
