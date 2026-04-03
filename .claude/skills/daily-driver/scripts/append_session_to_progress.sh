#!/usr/bin/env bash
# Append continuation session to progress.md
# Usage: append_session_to_progress.sh <task_folder> <yesterday_date>
# Example: append_session_to_progress.sh "/path/to/task_M1_test" "2026-04-02"

progress_file="$1"
yesterday_date="$2"

if [ -z "$progress_file" ] || [ -z "$yesterday_date" ]; then
    echo "Error: progress_file and yesterday_date required" >&2
    exit 1
fi

today_date=$(date '+%Y-%m-%d')
current_time=$(date '+%H:%M')
session_num=$(grep -c "Session" "$progress_file" 2>/dev/null || echo "0")
session_num=$((session_num + 1))

cat >> "$progress_file" << EOF

## Session ${session_num}: ${today_date}

### ${current_time} - 任务延续
- 📅 延续自：${yesterday_date}
- 📍 当前状态：继续执行

---
EOF

echo "APPENDED:Session $session_num"
