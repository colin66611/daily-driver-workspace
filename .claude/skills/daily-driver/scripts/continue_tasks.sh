#!/usr/bin/env bash
# Continue tasks from yesterday to today
# Usage: continue_tasks.sh <task_ids>
# Example: continue_tasks.sh "M1 M2"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
task_ids="$1"
today=$(date '+%Y-%m-%d')
yesterday=$("$SCRIPT_DIR/get_yesterday_date.sh")
daily_path="${PWD}/others/daily"

# Copy each task
for task_id in $task_ids; do
    # Find yesterday's task folder
    yesterday_task=$(ls -d "$daily_path/$yesterday"/task_${task_id}_*/ 2>/dev/null | head -1)
    if [ -n "$yesterday_task" ]; then
        task_name=$(basename "$yesterday_task")
        today_task="$daily_path/$today/$task_name"

        # Copy task folder
        cp -r "$yesterday_task" "$today_task"

        # Update last modified time
        "${SCRIPT_DIR}/update_last_modified.sh" "$today_task/task_plan.md"

        echo "CONTINUED:$task_name"
    else
        echo "NOT_FOUND:$task_id"
    fi
done
