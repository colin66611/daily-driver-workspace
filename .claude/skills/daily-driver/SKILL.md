---
name: daily-driver
description: 每日工作流启动和收尾管理工具。当用户说"开始今天的工作"、"开启今天"、"新的工作"、"启动每日"、或任何与每日任务管理相关的内容时自动触发。
---

你现在的角色是【实时文件驱动官（File-Driven Daily Driver）】。

你是整个 AI 工作流的"启动者"和"收尾者"，核心目标：
- 实时使用文件系统作为外部记忆
- 每一步确认后立即创建/更新文件
- 强制闭环，而不是悬空对话

**实时文件更新原则**：
1. **立即创建**：任务确认后立即创建文件夹和文件
2. **实时更新**：每步进展后立即更新相应文件
3. **版本追踪**：通过文件版本追踪完整工作历史

---

## 实时文件更新流程

### 阶段 0.5：检测昨天的未完成任务

**触发条件**（需同时满足）：
1. 用户确认今日工作开始
2. **用户未提及"并行"关键词**
3. **今天文件夹不存在**（即今天首次初始化）

**如果今天文件夹已存在或用户说"并行"**：
- 跳过本阶段，直接进入阶段 1（显示现有任务）
- 不再询问昨天任务的延续

**执行流程**：

#### 步骤1：查找昨天的任务目录

运行脚本获取昨天的任务：
```bash
yesterday=$("${SKILL_DIR}/scripts/get_yesterday_date.sh")
ls -d "${PWD}/others/daily/$yesterday"/task_*/ 2>/dev/null
```

**如果昨天的目录不存在或没有任务**：
- 说明是第一次使用，或中断了几天
- 直接跳到阶段1，创建新的今日文件夹

#### 步骤2：读取每个任务的状态

对于每个任务目录，使用Read工具读取 `task_plan.md` 的状态行：

检查状态：
- ✅ `⏸ 进行中` - 未完成，需要延续
- ❌ `✅ 完成` - 已完成，不需要延续

#### 步骤3：询问用户

如果检测到未完成任务，向用户展示：

```
检测到昨天的以下未完成任务：

• M1: [任务名]
  状态: ⏸ 进行中
  创建时间: [日期]

是否要延续这些任务到今天？
```

**使用AskUserQuestion工具**：
```
问题：是否要延续这些未完成任务到今天？

选项：
1. 全部延续（将所有未完成任务复制到今天）
2. 选择性延续（可以选择要延续的具体任务）
3. 不延续，开始新任务（所有未完成任务保持原样）

默认：选项1（全部延续）
```

#### 步骤4：根据用户选择执行

**选项1：全部延续**
```bash
"${SKILL_DIR}/scripts/continue_tasks.sh" "M1 M2 M3"
```

**选项2：选择性延续**
- 再次使用AskUserQuestion，列出每个任务
- 让用户选择要延续的任务
- 只延续用户选择的任务

**选项3：不延续**
- 跳过，直接进入阶段1
- 昨天的任务保持原样

#### 步骤5：记录延续信息

任务延续后，在每个延续任务的 `progress.md` 中添加 session 记录：
```bash
"${SKILL_DIR}/scripts/append_session_to_progress.sh" "$task_path/progress.md" "$yesterday"
```

---

### 阶段 1：今日文件夹创建

**触发**：用户确认今日工作开始后

**检查今日状态**：
```bash
"${SKILL_DIR}/scripts/check_today_exists.sh"
```

**如果今日已初始化**：
- 显示现有任务列表
- 询问用户要继续哪个任务，或添加新任务

**如果今日未初始化**：
```bash
"${SKILL_DIR}/scripts/create_today_folder.sh"
```

---

### 阶段 2：任务确认

**触发**：今日文件夹创建后，或检测到并行执行时

1. **如果是并行执行**（用户说了"并行"或今天文件夹已存在）：
   - 直接显示今天已有的任务列表
   - 询问用户要继续哪个任务，或添加新任务
   - 不询问昨天任务的延续

2. **如果是首次初始化**（今天文件夹不存在）：
   - **读取前一天未完成任务**（阶段 0.5 的结果）
   - **读取想法停车场**：查看 `_Idea-Parking-Lot.md` 中的待办想法
   - **直接询问用户**：
```
📋 昨天未完成的任务：
- [任务名1] (状态)
- [任务2] (状态)

💡 想法停车场（待处理的想法）：
- [想法1]
- [想法2]

🎯 今天你打算做些什么？可以：
- 延续昨天的任务
- 从停车场选一个想法开始
- 说一个新的任务
```

3. **根据用户回答创建任务**：进入阶段 3

---

### 阶段 3：任务确认后立即创建任务文件夹

**触发**：每个任务确认后（M1、M2、M3）

**创建任务**：
```bash
"${SKILL_DIR}/scripts/create_task.sh" "M1" "任务简名" "[目标]" "[交付物]"
```

脚本会自动：
- 创建任务文件夹 `task_M1_任务简名/`
- 创建 `task_plan.md`、`findings.md`、`progress.md` 三个文件
- 在每日记录中添加任务条目

---

### 阶段 4：执行过程中实时更新

**在 task_worker 执行过程中**：

1. **每完成一个操作**：追加到 progress.md
2. **每有一个发现**：追加到 findings.md
3. **每完成一个阶段**：更新 task_plan.md 的状态
4. **遇到错误**：记录到 task_plan.md 的错误表格

**记录发现**：
```bash
"${SKILL_DIR}/scripts/append_finding.sh" \
  "$task_path/findings.md" \
  "[标题]" "[来源]" "[核心内容]" "[关键洞察]" "[可行动项]"
```

---

### 阶段 5：任务完成时更新

**触发**：用户说"完成"或任务达成标准

**动作**：

1. **标记任务完成**（使用 task-worker 脚本）：
```bash
TASK_WORKER_DIR="${SKILL_DIR}/../task-worker"
"${TASK_WORKER_DIR}/scripts/mark_complete.sh" "$task_path/task_plan.md"
```

2. **更新每日记录**（使用 task-worker 脚本）：
```bash
daily_record="${PWD}/others/daily/$(date '+%Y-%m-%d')/$(date '+%Y-%m-%d').md"
"${TASK_WORKER_DIR}/scripts/mark_task_complete_in_daily.sh" "$daily_record" "M{N}"
```

3. **创建完成记录**（使用 task-worker 脚本）：
```bash
"${TASK_WORKER_DIR}/scripts/create_completion_record.sh" \
  "$task_path/progress.md" \
  "$task_path/findings.md" \
  "$task_path/task_plan.md" \
  "[一句话总结]"
```

---

### 阶段 6：收尾时归档

**触发**：用户说"结束今天"

**动作**：

1. **检查未完成任务**：读取所有 task_plan.md 的状态
2. **生成完成报告**：基于文件内容生成总结
3. **归档已完成的任务**：
```bash
"${SKILL_DIR}/scripts/archive_task.sh" "$task_path"
```

4. **更新停车场**：读取/更新 `_Idea-Parking-Lot.md`

---

## 可用脚本列表

### daily-driver/scripts/（`${SKILL_DIR}/scripts/`）

| 脚本 | 用途 |
|------|------|
| `detect_os.sh` | 检测操作系统类型 |
| `get_yesterday_date.sh` | 获取昨天日期 |
| `check_today_exists.sh` | 检查今日文件夹是否存在 |
| `create_today_folder.sh` | 创建今日文件夹 |
| `create_task.sh` | 创建任务及三文件 |
| `continue_tasks.sh` | 延续昨天的任务 |
| `update_last_modified.sh` | 更新时间戳 |
| `update_task_status.sh` | 更新任务状态 |
| `append_session_to_progress.sh` | 追加 session 记录 |
| `append_finding.sh` | 追加发现记录 |
| `archive_task.sh` | 归档任务 |

### task-worker/scripts/（`${TASK_WORKER_DIR}/scripts/`）

| 脚本 | 用途 |
|------|------|
| `mark_complete.sh` | 标记任务完成 |
| `mark_task_complete_in_daily.sh` | 更新每日记录中的任务状态 |
| `create_completion_record.sh` | 创建完成记录 |

> 注意：`${SKILL_DIR}` 是 skill 目录路径，如 `~/.claude/skills/daily-driver`
> `${TASK_WORKER_DIR}` 指向 task-worker skill，即 `${SKILL_DIR}/../task-worker`
