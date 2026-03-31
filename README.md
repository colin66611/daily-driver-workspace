# Daily Driver Workspace

> 想象一下：你的 AI 助手有「长期记忆」。
>
> 你不需要记住昨天聊到哪，不用整理笔记，不用写文档——
> 只需说"开启工作"，Agent 自动唤醒昨日任务、呈现今日选项、实时记录每一步。
>
> 文件是你的外脑，Agent 是你的副驾。
> 你专注决策，剩下的交给 Daily Driver。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 三句话讲清 Daily Driver

- **每日启动**：说"开启工作"，Agent 自动检测昨日未完成任务 + 读取想法停车场
- **任务创建**：确认今日任务后，自动生成文件夹和**三文件系统**（plan/progress/findings）
- **实时记录**：执行中自动保存到文件，随时中断随时恢复，不再依赖 AI 的上下文窗口

---

## 📸 演示

### 30秒看懂 Daily Driver

<video src="https://github.com/user-attachments/assets/571957493-4666de1b-db6d-44e1-8fb6-146818a24a0c" autoplay loop muted playsinline width="100%"></video>

<details open>
<summary>🎬 查看视频解析（点击收起）</summary>

| 步骤 | 命令/输出 | 说明 |
|------|-----------|------|
| **① 输入启动命令** | `开启今天的工作` | Agent 检测环境并准备启动 |
| **② 检测昨天任务** | `📋 昨天的未完成任务：`<br>`• M1: xxx (⏸ 进行中)`<br>`• M2: xxx (⏸ 进行中)` | 自动读取昨日未完成项 |
| **③ 显示想法停车场** | `🅿️ 想法停车场：`<br>`• 学习新技术`<br>`• 整理读书笔记` | 展示待处理的想法列表 |
| **④ 确认今日任务** | `🎯 今天你打算做些什么？` | 用户选择要处理的事项 |
| **⑤ 创建任务文件夹** | `📁 创建任务文件夹...`<br>`✅ 今日工作已锁定` | 自动生成三文件系统 |

</details>

---

## ✨ 核心功能

| 功能 | 说明 |
|------|------|
| 🔍 **昨日任务检测** | 自动读取昨日未完成的 M1/M2/M3 任务，询问是否延续 |
| 🅿️ **想法停车场** | 集中管理待办想法，随时取用，防止灵感流失 |
| 🗂️ **三文件系统** | 每个任务标配 plan/progress/findings，结构化记录完整生命周期 |
| ✅ **5层检查点** | 从需求澄清到边界检查，防止 AI 跑偏 |
| 🪟 **多窗口并行** | 支持多个终端/窗口同时处理不同任务，互不干扰 |

---

## 🧠 设计巧思

### 文件即记忆

所有任务状态保存在文件系统，不依赖 AI 的 Context Window。

- **随时中断**：关闭终端、切换设备，不影响任务状态
- **随时恢复**：打开任意会话，从文件继续工作
- **多窗口并行**：同时开多个窗口处理不同任务，文件保证状态一致

### 自动化

Agent 自动完成繁琐的「记账」工作：

- **自动检测**：昨日有哪些任务未完成
- **自动创建**：任务确认后立即生成文件夹和文件
- **自动记录**：每步进展实时写入 progress.md

你只负责决策，Agent 负责执行。

### 强制闭环

> 本模式复用了 [planning-with-files](https://github.com/OthmanAdi/planning-with-files) 的三文件思想，只做少量场景化改动。

每个任务必须有完整记录：

```
计划 → 执行 → 发现 → 完成
```

- **task_plan.md**：明确目标、交付物、完成标准（复用 planning-with-files）
- **progress.md**：执行日志和时间线（复用 planning-with-files）
- **findings.md**：研究发现和参考资料（复用 planning-with-files）

拒绝悬空对话，每个任务都有始有终。

---

## 🚀 快速开始

### 方式一：Agent 自动安装（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace

# 2. 告诉 Agent："读取 AGENT_SETUP.md 并完成安装"
# Agent 会自动完成后续所有步骤
```

### 方式二：手动安装

```bash
# 1. 克隆仓库
git clone https://github.com/colin66611/daily-driver-workspace.git
cd daily-driver-workspace

# 2. 运行安装脚本
./install.sh

# 3. 输入知识库根目录路径（默认当前目录）
```

### 方式三：复制技能

```bash
# 1. 复制技能到 Claude Code
cp -r .claude/skills/* ~/.claude/skills/

# 2. 创建你的工作区
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

       🎯 今天你打算做些什么？可以：
       - 延续昨天的任务
       - 从停车场选一个想法开始
       - 说一个新的任务

你：处理学习新技术，延续M2

Agent：[生成任务提案并逐条确认]
       [确认规格]
       [创建任务文件夹和文件]

       ✅ 今日工作已锁定。准备开始工作。
       需要我展开哪个任务？
```

### 展开具体任务

```
你：展开 M1

Agent：[读取 task_plan.md]
       🔒 规格已锁定
       [开始执行任务]
       [每2个操作保存发现到 findings.md]
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

## 📁 文件结构

```
你的知识库/
├── CLAUDE.md                 # 项目指导和长期记忆
├── work/                     # 工作归档（长期存储）
├── life/                     # 生活归档（长期存储）
├── learning/                 # 学习归档（长期存储）
└── others/
    ├── daily/                # 每日工作区（活跃任务）
    │   ├── _Idea-Parking-Lot.md
    │   └── 2026-03-30/       # 按日期组织
    │       ├── 2026-03-30.md
    │       └── task_M1_任务名/
    │           ├── task_plan.md
    │           ├── progress.md
    │           └── findings.md
    └── demo/
```

### 工作流：活跃 → 归档

Daily Driver 把「记笔记」的过程自动化了：

| 阶段 | 位置 | 说明 |
|------|------|------|
| **创建** | `daily/YYYY-MM-DD/` | 所有任务默认在此创建和执行 |
| **进行中** | `daily/` 下实时更新 | 自动记录 progress/findings |
| **完成** | 留在 `daily/` 或归档 | 只有**有复用价值**的内容才归档 |
| **归档** | `work/` / `life/` / `learning/` | Agent 自动分类到长期存储区 |

**怎么决定归档到哪？**
- **work/**：职场项目、技术方案、业务文档
- **life/**：健康管理、财务规划、生活经验
- **learning/**：读书笔记、技术研究、课程总结

**关键原则**：
- `daily/` 是「工作台」——只放正在进行的事
- `work/life/learning` 是「精选档案」——只放有价值、可能复用的内容
- 大部分任务完成后留在 daily 即可，有价值的才需要说「归档到 learning」

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

## 📚 文档

- [AGENT_SETUP.md](AGENT_SETUP.md) - 给 AI 看的安装指南
- [示例工作区](examples/) - 完整的工作区示例
- [设计文档](docs/design.md) - 系统设计详情

---

## 🔧 系统要求

- [Claude Code](https://claude.ai/code) 或 [OpenCode](https://github.com/your-username/opencode)
- Unix-like 系统（macOS / Linux）
- Git

---

## 🤝 贡献

欢迎提交 Issue 和 PR！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送分支 (`git push origin feature/amazing`)
5. 创建 Pull Request

---

## 📄 许可证

[MIT](LICENSE) © Colin Song

---

## 🙏 致谢

- **三文件系统**思想受到 [planning-with-files](https://github.com/OthmanAdi/planning-with-files) 的启发
- 灵感来自 [Claude Code](https://claude.ai/code)

---

**Star ⭐ 这个仓库如果它帮助了你！**
