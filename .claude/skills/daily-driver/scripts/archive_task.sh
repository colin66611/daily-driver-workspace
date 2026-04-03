#!/usr/bin/env bash
# Archive completed task to completed folder
# Usage: archive_task.sh <task_folder>
# Example: archive_task.sh "/path/to/task_M1_test"

task_folder="$1"

if [ -z "$task_folder" ]; then
    echo "Error: task_folder required" >&2
    exit 1
fi

# Get parent directory and task name
task_name=$(basename "$task_folder")
completed_path="$(dirname "$task_folder")/completed"

# Create completed folder if not exists
mkdir -p "$completed_path"

# Move task to completed
mv "$task_folder" "$completed_path/"

echo "ARCHIVED:$completed_path/$task_name"
