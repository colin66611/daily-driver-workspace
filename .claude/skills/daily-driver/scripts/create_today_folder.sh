#!/usr/bin/env bash
# Create today's folder and daily record file
# Usage: create_today_folder.sh

daily_path="${PWD}/others/daily"
today=$(date '+%Y-%m-%d')
today_path="$daily_path/$today"
today_record="$today_path/$today.md"

# Create folder if not exists
if [ ! -d "$today_path" ]; then
    mkdir -p "$today_path"
fi

# Create daily record if not exists
if [ ! -f "$today_record" ]; then
    cat > "$today_record" << EOF
# $today

## 主线任务
待确认

## 副线探索
待添加

## 今日新增想法
待添加
EOF
    echo "CREATED:$today_record"
else
    echo "EXISTS:$today_record"
fi
