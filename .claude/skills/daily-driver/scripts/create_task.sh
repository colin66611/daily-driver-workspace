#!/usr/bin/env bash
# Create task folder with three files (task_plan.md, findings.md, progress.md)
# Usage: create_task.sh <task_id> <task_name> [goal] [deliverables]
# Example: create_task.sh M1 "DailyDriver开源" "实现多窗口并行" "代码和文档"

task_id="$1"
task_name="$2"
goal="${3:-[待确认]}"
deliverables="${4:-[待确认]}"
today=$(date '+%Y-%m-%d')
current_time=$(date '+%Y-%m-%d %H:%M')
daily_path="${PWD}/others/daily"
task_path="$daily_path/$today/task_${task_id}_${task_name}"

# Create task folder
mkdir -p "$task_path"

# Create task_plan.md
cat > "$task_path/task_plan.md" << EOF
# 任务计划：${task_id} - ${task_name}

**任务状态**: ⏸ 进行中
**创建时间**: ${current_time}
**最后更新**: ${current_time}

## 任务目标
${goal}

## 预期交付物
${deliverables}

## 完成标准
- [ ] [标准1]
- [ ] [标准2]
- [ ] [标准3]

## 执行阶段
### Phase 1: [阶段名]
- [ ] 步骤1
- [ ] 步骤2

## 下一步行动
1. [最优先的下一步]

## 当前障碍
[无 / 具体障碍描述]

## 错误记录
| Error | Attempt | Resolution |
|-------|---------|------------|
EOF

# Create findings.md
cat > "$task_path/findings.md" << EOF
# 研究发现：${task_id} - ${task_name}

## 关键发现

## 参考资料
EOF

# Create progress.md
cat > "$task_path/progress.md" << EOF
# 进展日志：${task_id} - ${task_name}

## Session 1: ${today}

### $(date '+%H:%M') - 任务初始化
- ✅ 创建 task_plan.md
- ✅ 创建 findings.md
- ✅ 创建 progress.md
- 📍 当前状态：准备开始

---

## 下一步
1. [具体行动]
EOF

# Add task to daily record
daily_record="$daily_path/$today/$today.md"
if [ -f "$daily_record" ]; then
    echo "- ${task_id}: ${task_name} (状态: ⏸ 进行中)" >> "$daily_record"
fi

echo "CREATED:$task_path"
