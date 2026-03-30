# AGENT_SETUP.md

> 🎯 这是给 AI (Claude Code / OpenCode) 看的安装指南

如果你是人类用户，请查看 [README.md](README.md)。

---

## 🎯 你的任务

读取本文档后，自动完成 Daily Driver Workspace 的安装部署。

---

## ✅ 前置检查

### 步骤 1：验证当前目录
检查以下文件/目录是否存在：
- `.claude/skills/daily-driver/SKILL.md`
- `.claude/skills/task-worker/SKILL.md`
- `install.sh`

如果不存在，告知用户："请确保你在 daily-driver-workspace 仓库根目录运行。"

---

## 📦 安装步骤

### 步骤 2：询问知识库路径

向用户询问：

```
你打算把知识库的根目录放在哪个路径？
（默认：$(pwd)）：
```

- 如果用户直接回车，使用默认路径 `$(pwd)`
- 如果用户提供路径，使用该路径

将路径保存为变量：`KNOWLEDGE_BASE`

### 步骤 3：安装 Skills

执行以下命令：

```bash
# 创建 Claude Code skills 目录（如果不存在）
mkdir -p ~/.claude/skills

# 复制 daily-driver skill
cp -r .claude/skills/daily-driver ~/.claude/skills/

# 复制 task-worker skill
cp -r .claude/skills/task-worker ~/.claude/skills/

# 验证安装
ls ~/.claude/skills/daily-driver/
ls ~/.claude/skills/task-worker/
```

### 步骤 4：创建知识库结构

执行以下命令：

```bash
# 创建文件夹结构
mkdir -p "${KNOWLEDGE_BASE}/learning"
mkdir -p "${KNOWLEDGE_BASE}/life"
mkdir -p "${KNOWLEDGE_BASE}/work/management"
mkdir -p "${KNOWLEDGE_BASE}/others/daily"
mkdir -p "${KNOWLEDGE_BASE}/others/demo"

# 复制 CLAUDE.md 模板
cp examples/CLAUDE.md "${KNOWLEDGE_BASE}/CLAUDE.md"

# 创建想法停车场
cat > "${KNOWLEDGE_BASE}/others/daily/_Idea-Parking-Lot.md" << 'EOF'
# 🅿️ 想法停车场

## 🔄 待办事项

<!-- 在这里记录临时想法 -->

- **示例想法**
  - **背景**: 这是一个示例想法
  - **目标**: 展示如何记录想法
  - **预期交付物**: 示例文档
  - **优先级**: 🟡 中

---

## 📝 待处理任务（已归档）

---

## 🔗 相关链接

EOF

# 创建快速上手指南
cat > "${KNOWLEDGE_BASE}/others/daily/_QuickStart-Guide.md" << 'EOF'
# 🚀 Daily Driver 快速上手指南

## 基本命令

### 1. 启动今天的工作
```
用户：开启今天的工作
Agent：[询问能量状态] → [显示想法停车场] → [确认任务]
```

### 2. 展开任务
```
用户：展开 M1
Agent：[读取 task_plan.md] → [开始执行]
```

### 3. 完成任务
```
用户：完成
Agent：[更新状态] → [生成总结]
```

### 4. 结束一天
```
用户：结束今天的工作
Agent：[总结今日] → [归档完成项]
```

## 文件命名规范

- 日期目录：`YYYY-MM-DD/`
- 任务目录：`task_M{数字}_{任务简名}/`
- 任务文件：`task_plan.md`, `progress.md`, `findings.md`

## 提示

- 随时可以说"保存"让 Agent 立即保存当前进展
- 任务规格一旦确认不可更改，如需更改需新建任务
- 每2个操作后会自动保存发现
EOF
```

### 步骤 5：验证安装

检查以下内容：

```bash
# 检查 skills
test -f ~/.claude/skills/daily-driver/SKILL.md && echo "✅ daily-driver skill 安装成功"
test -f ~/.claude/skills/task-worker/SKILL.md && echo "✅ task-worker skill 安装成功"

# 检查知识库结构
test -d "${KNOWLEDGE_BASE}/learning" && echo "✅ learning/ 创建成功"
test -d "${KNOWLEDGE_BASE}/life" && echo "✅ life/ 创建成功"
test -d "${KNOWLEDGE_BASE}/work" && echo "✅ work/ 创建成功"
test -d "${KNOWLEDGE_BASE}/others/daily" && echo "✅ others/daily/ 创建成功"
test -f "${KNOWLEDGE_BASE}/CLAUDE.md" && echo "✅ CLAUDE.md 创建成功"
test -f "${KNOWLEDGE_BASE}/others/daily/_Idea-Parking-Lot.md" && echo "✅ 想法停车场创建成功"
```

---

## 🎉 安装完成

向用户报告：

```
✅ Daily Driver Workspace 安装完成！

📍 知识库位置：${KNOWLEDGE_BASE}
🧠 Skills 位置：~/.claude/skills/

📂 已创建的结构：
   ├── CLAUDE.md（项目指导）
   ├── learning/
   ├── life/
   ├── work/
   └── others/
       └── daily/
           ├── _Idea-Parking-Lot.md（想法停车场）
           └── _QuickStart-Guide.md（快速上手指南）

🚀 试试说：开启今天的工作
```

---

## 🔧 故障排除

### 问题：Skills 没有生效
**解决**：
1. 检查 `~/.claude/skills/` 是否存在
2. 重启 Claude Code
3. 确认 skill 文件格式正确

### 问题：权限错误
**解决**：
```bash
chmod +x install.sh
```

### 问题：路径问题
**解决**：
- 确保使用绝对路径
- 检查目录是否存在

---

## 📚 更多信息

- 人类用户文档：[README.md](README.md)
- 示例工作区：[examples/](examples/)
- 设计文档：[docs/design.md](docs/design.md)
