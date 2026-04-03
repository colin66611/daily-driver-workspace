#!/usr/bin/env bash
# Mark task as complete in task_plan.md (cross-platform)
# Usage: mark_complete.sh <task_plan_path>

task_file="$1"

if [ -z "$task_file" ]; then
    echo "Error: task_file path required" >&2
    exit 1
fi

# Mark as complete
sed -i 's/⏸ 进行中/✅ 完成/' "$task_file" 2>/dev/null || \
sed -i '' 's/⏸ 进行中/✅ 完成/' "$task_file"

# Update timestamp
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/update_last_modified.sh" "$task_file"
