#!/usr/bin/env bash
# Update task status in task_plan.md (cross-platform)
# Usage: update_task_status.sh <task_plan_path> <old_status> <new_status>
# Example: update_task_status.sh "/path/to/task_plan.md" "⏸ 进行中" "✅ 完成"

task_file="$1"
old_status="$2"
new_status="$3"

if [ -z "$task_file" ] || [ -z "$old_status" ] || [ -z "$new_status" ]; then
    echo "Error: task_file, old_status, and new_status required" >&2
    exit 1
fi

# Linux/Git Bash (GNU sed) - sed -i 'pattern'
# macOS (BSD sed) - sed -i '' 'pattern'
sed -i "s/$old_status/$new_status/" "$task_file" 2>/dev/null || \
sed -i '' "s/$old_status/$new_status/" "$task_file"
