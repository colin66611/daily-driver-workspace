#!/usr/bin/env bash
# Append error record to task_plan.md and progress.md
# Usage: append_error.sh <task_plan_file> <progress_file> <error_desc> <attempt_num> <solution>
# Example: append_error.sh "/path/plan.md" "/path/progress.md" "连接失败" "2" "重试"

plan_file="$1"
progress_file="$2"
error_desc="$3"
attempt_num="$4"
solution="$5"

if [ -z "$plan_file" ] || [ -z "$progress_file" ]; then
    echo "Error: plan_file and progress_file required" >&2
    exit 1
fi

# Default values
error_desc="${error_desc:-未知错误}"
attempt_num="${attempt_num:-1}"
solution="${solution:-[待解决]}"

# Append to task_plan.md error table
error_count=$(grep -c '| Error ' "$plan_file" 2>/dev/null)
error_count=$((error_count + 1))

cat >> "$plan_file" << EOF
| Error ${error_count} | ${error_desc} | ${solution} |
EOF

# Append to progress.md
current_time=$(date '+%H:%M')
cat >> "$progress_file" << EOF

### $current_time - 遇到错误
- ⚠️ 错误: ${error_desc}
- 🔄 尝试: 第${attempt_num}次
- 💡 解决方案: ${solution}
EOF

echo "APPENDED:Error $error_count"
