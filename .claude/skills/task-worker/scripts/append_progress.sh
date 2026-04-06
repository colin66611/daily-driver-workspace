#!/usr/bin/env bash
# Append entry to progress.md
# Usage: append_progress.sh <progress_file> <entry_type> <description> [status]
# Example: append_progress.sh "/path/to/progress.md" "完成" "阅读了文档" "新状态"

progress_file="$1"
entry_type="$2"
description="$3"
status="${4:-}"

if [ -z "$progress_file" ] || [ -z "$entry_type" ]; then
    echo "Error: progress_file and entry_type required" >&2
    exit 1
fi

current_time=$(date '+%H:%M')

entry="### $current_time - $entry_type\n- ✅ $description"
if [ -n "$status" ]; then
    entry="$entry\n- 📍 新状态: $status"
fi

echo -e "$entry" >> "$progress_file"

echo "APPENDED:$entry_type"
