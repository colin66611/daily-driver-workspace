#!/usr/bin/env bash
# Update "最后更新" timestamp in task_plan.md (cross-platform sed -i)
# Usage: update_last_modified.sh <task_plan_path>

task_file="$1"
new_time=$(date '+%Y-%m-%d %H:%M')

if [ -z "$task_file" ]; then
    echo "Error: task_file path required" >&2
    exit 1
fi

# Linux/Git Bash (GNU sed) - sed -i 'pattern'
# macOS (BSD sed) - sed -i '' 'pattern'
# Pattern matches both "最后更新" and "**最后更新**"
sed -i "s/\*\*最后更新\*\*: .*/\*\*最后更新\*\*: $new_time/" "$task_file" 2>/dev/null || \
sed -i '' "s/\*\*最后更新\*\*: .*/\*\*最后更新\*\*: $new_time/" "$task_file"
