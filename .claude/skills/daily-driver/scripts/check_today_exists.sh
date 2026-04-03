#!/usr/bin/env bash
# Check if today's folder exists and list existing tasks
# Usage: check_today_exists.sh
# Output: JSON-like status or task list

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
daily_path="${PWD}/others/daily"
today=$(date '+%Y-%m-%d')
today_path="$daily_path/$today"
today_record="$today_path/$today.md"

if [ -d "$today_path" ] && [ -f "$today_record" ]; then
    echo "EXISTS"

    # List existing tasks
    task_count=$(ls -d "$today_path"/task_*/ 2>/dev/null | wc -l | tr -d ' ')
    if [ "$task_count" -gt 0 ]; then
        echo "TASKS:$task_count"
        for task_dir in "$today_path"/task_*/; do
            if [ -d "$task_dir" ] && [ -f "$task_dir/task_plan.md" ]; then
                task_name=$(basename "$task_dir")
                # Get task name from task_plan.md (line 1, remove #)
                task_title=$(head -1 "$task_dir/task_plan.md" 2>/dev/null | sed 's/^# //')
                # Get status
                status=$(grep '任务状态' "$task_dir/task_plan.md" 2>/dev/null | cut -d ':' -f 2 | tr -d ' ')
                echo "TASK:$task_name|$task_title|$status"
            fi
        done
    fi
else
    echo "NEW"
fi
