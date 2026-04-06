#!/usr/bin/env bash
# Mark task as complete in daily record (cross-platform)
# Usage: mark_task_complete_in_daily.sh <daily_record_path> <task_id>
# Example: mark_task_complete_in_daily.sh "/path/to/daily/2026-04-03.md" "M1"

daily_record="$1"
task_id="${2:-M1}"

if [ -z "$daily_record" ]; then
    echo "Error: daily_record path required" >&2
    exit 1
fi

# Linux/Git Bash (GNU sed) - sed -i 'pattern'
# macOS (BSD sed) - sed -i '' 'pattern'
sed -i "s/${task_id}: .*(状态: ⏸ 进行中)/${task_id}: [任务名] (状态: ✅ 完成)/" "$daily_record" 2>/dev/null || \
sed -i '' "s/${task_id}: .*(状态: ⏸ 进行中)/${task_id}: [任务名] (状态: ✅ 完成)/" "$daily_record"
