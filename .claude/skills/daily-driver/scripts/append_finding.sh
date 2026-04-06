#!/usr/bin/env bash
# Append a finding to findings.md
# Usage: append_finding.sh <findings_file> <title> <source> <content> <insight> <action>
# Example: append_finding.sh "/path/to/findings.md" "标题" "搜索" "核心内容" "关键洞察" "下一步行动"

findings_file="$1"
title="$2"
source="$3"
content="$4"
insight="$5"
action="$6"

if [ -z "$findings_file" ]; then
    echo "Error: findings_file required" >&2
    exit 1
fi

# Default values if not provided
title="${title:-新发现}"
source="${source:-[来源]}"
content="${content:-[内容]}"
insight="${insight:-[洞察]}"
action="${action:-[行动]}"

findings_time=$(date '+%Y-%m-%d %H:%M')
finding_num=$(grep -c "### Finding" "$findings_file" 2>/dev/null)
finding_num=$((finding_num + 1))

cat >> "$findings_file" << EOF

### Finding ${finding_num}: ${title}
- **发现时间**: ${findings_time}
- **来源**: ${source}
- **核心内容**: ${content}
- **关键洞察**: ${insight}
- **可行动项**: ${action}
EOF

echo "APPENDED:Finding $finding_num"
