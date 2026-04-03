#!/usr/bin/env bash
# Create task completion record in progress.md
# Usage: create_completion_record.sh <progress_file> <findings_file> <plan_file> <summary>
# Example: create_completion_record.sh "/path/progress.md" "/path/findings.md" "/path/plan.md" "完成了核心功能"

progress_file="$1"
findings_file="$2"
plan_file="$3"
summary="${4:-[一句话总结]}"

if [ -z "$progress_file" ]; then
    echo "Error: progress_file required" >&2
    exit 1
fi

current_time=$(date '+%H:%M')

# Count findings
finding_count=$(grep -c '### Finding' "$findings_file" 2>/dev/null || echo "0")

# Count errors
error_count=$(grep -c '| Error ' "$plan_file" 2>/dev/null || echo "0")

cat >> "$progress_file" << EOF

### $current_time - 任务完成
- 🎉 核心成果: ${summary}
- 📊 总计发现: ${finding_count} 个关键发现
- ⚠️ 遇到错误: ${error_count} 次
EOF

echo "CREATED:Completion record"
