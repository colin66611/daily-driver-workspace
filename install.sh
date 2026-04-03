#!/usr/bin/env bash

# Daily Driver Workspace 安装脚本
# 用法: ./install.sh
# 支持: macOS, Linux, Windows Git Bash

set -e  # 遇到错误立即退出

# ============================================
# 跨平台检测与工具函数
# ============================================

# 检测操作系统类型（仅区分 Mac / Windows，Linux 归为 Unix）
detect_os() {
    # 先检测 Mac（最准确：sw_vers 是 Mac 独有的）
    if command -v sw_vers > /dev/null 2>&1; then
        echo "macOS"
    # 检测 Windows（Git Bash / MSYS / Cygwin）
    elif [ -n "$COMSPEC" ] || [[ "$(uname -o 2>/dev/null)" == *"Msys"* ]] || [[ "$OSTYPE" == *"msys"* ]]; then
        echo "Windows"
    else
        echo "Linux/Unix"
    fi
}

OS_TYPE=$(detect_os)
echo "检测到操作系统: $OS_TYPE"

# 获取昨天的日期（跨平台）
get_yesterday_date() {
    case "$OS_TYPE" in
        macOS)
            date -v-1d '+%Y-%m-%d'
            ;;
        Windows)
            # Git Bash / MSYS 支持 date -d
            date -d 'yesterday' '+%Y-%m-%d' 2>/dev/null || \
            python3 -c "from datetime import date, timedelta; print((date.today() - timedelta(1)).isoformat())"
            ;;
        *)
            date -d 'yesterday' '+%Y-%m-%d'
            ;;
    esac
}

# 获取当前日期
get_today_date() {
    date '+%Y-%m-%d'
}

# sed -i 的跨平台写法（已废弃，改用内联 fallback）
# 现在直接在命令后加 || fallback，更简洁

echo "🚀 Daily Driver Workspace 安装程序"
echo "====================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 步骤 1: 询问知识库路径
echo -e "${BLUE}步骤 1/5: 配置知识库路径${NC}"
echo ""
echo "你打算把知识库的根目录放在哪个路径？"
echo -n "（默认：$SCRIPT_DIR）: "
read -r KNOWLEDGE_BASE

# 使用默认值
if [ -z "$KNOWLEDGE_BASE" ]; then
    KNOWLEDGE_BASE="$SCRIPT_DIR"
fi

# 转换为绝对路径
KNOWLEDGE_BASE="$(cd "$KNOWLEDGE_BASE" && pwd)"

echo ""
echo -e "📍 知识库路径: ${GREEN}$KNOWLEDGE_BASE${NC}"
echo ""

# 步骤 2: 安装 Skills
echo -e "${BLUE}步骤 2/5: 安装 Skills${NC}"
echo ""

# 创建 Claude Code skills 目录
mkdir -p ~/.claude/skills

# 复制 daily-driver skill
if [ -d "$SCRIPT_DIR/.claude/skills/daily-driver" ]; then
    cp -r "$SCRIPT_DIR/.claude/skills/daily-driver" ~/.claude/skills/
    echo -e "${GREEN}✅ daily-driver skill 安装成功${NC}"
else
    echo -e "${YELLOW}⚠️  daily-driver skill 源文件不存在${NC}"
fi

# 复制 task-worker skill
if [ -d "$SCRIPT_DIR/.claude/skills/task-worker" ]; then
    cp -r "$SCRIPT_DIR/.claude/skills/task-worker" ~/.claude/skills/
    echo -e "${GREEN}✅ task-worker skill 安装成功${NC}"
else
    echo -e "${YELLOW}⚠️  task-worker skill 源文件不存在${NC}"
fi

echo ""

# 步骤 3: 创建知识库结构
echo -e "${BLUE}步骤 3/5: 创建知识库结构${NC}"
echo ""

# 创建文件夹
mkdir -p "$KNOWLEDGE_BASE/learning"
mkdir -p "$KNOWLEDGE_BASE/life"
mkdir -p "$KNOWLEDGE_BASE/work/management"
mkdir -p "$KNOWLEDGE_BASE/others/daily"
mkdir -p "$KNOWLEDGE_BASE/others/demo"

echo -e "${GREEN}✅ 文件夹结构创建成功${NC}"

# 步骤 4: 复制模板文件
echo -e "${BLUE}步骤 4/5: 复制模板文件${NC}"
echo ""

# 复制 CLAUDE.md
if [ -f "$SCRIPT_DIR/examples/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/examples/CLAUDE.md" "$KNOWLEDGE_BASE/CLAUDE.md"
    echo -e "${GREEN}✅ CLAUDE.md 创建成功${NC}"
else
    # 创建默认的 CLAUDE.md
    cat > "$KNOWLEDGE_BASE/CLAUDE.md" << 'EOF'
# CLAUDE.md

这是你的个人知识库，使用 Daily Driver 工作流管理。

## 项目结构

- `learning/` - 学习相关内容
- `life/` - 生活相关内容
- `work/` - 工作相关内容
- `others/` - 其他内容
  - `daily/` - 每日工作区
  - `demo/` - 演示和测试

## Daily Driver 使用

- 启动：`开启今天的工作`
- 展开任务：`展开 M1`
- 完成任务：`完成`
- 结束：`结束今天的工作`

## 长期记忆

<!-- 在这里记录需要长期保存的信息 -->
EOF
    echo -e "${GREEN}✅ CLAUDE.md（默认模板）创建成功${NC}"
fi

# 创建想法停车场
if [ -f "$SCRIPT_DIR/examples/others/daily/_Idea-Parking-Lot.md" ]; then
    cp "$SCRIPT_DIR/examples/others/daily/_Idea-Parking-Lot.md" "$KNOWLEDGE_BASE/others/daily/"
    echo -e "${GREEN}✅ _Idea-Parking-Lot.md 创建成功${NC}"
else
    cat > "$KNOWLEDGE_BASE/others/daily/_Idea-Parking-Lot.md" << 'EOF'
# 🅿️ 想法停车场

## 🔄 待办事项

<!-- 在这里记录临时想法 -->

## 📝 待处理任务（已归档）

## 🔗 相关链接
EOF
    echo -e "${GREEN}✅ _Idea-Parking-Lot.md（默认模板）创建成功${NC}"
fi

# 创建快速上手指南
cat > "$KNOWLEDGE_BASE/others/daily/_QuickStart-Guide.md" << 'EOF'
# 🚀 Daily Driver 快速上手指南

## 基本命令

### 1. 启动今天的工作
```
你：开启今天的工作
Agent：[询问能量状态] → [显示想法停车场] → [确认任务]
```

### 2. 展开任务
```
你：展开 M1
Agent：[读取 task_plan.md] → [开始执行]
```

### 3. 完成任务
```
你：完成
Agent：[更新状态] → [生成总结]
```

### 4. 结束一天
```
你：结束今天的工作
Agent：[总结今日] → [归档完成项]
```

## 文件命名规范

- 日期目录：`YYYY-MM-DD/`
- 任务目录：`task_M{数字}_{任务简名}/`
- 任务文件：`task_plan.md`, `progress.md`, `findings.md`
EOF

echo -e "${GREEN}✅ _QuickStart-Guide.md 创建成功${NC}"

echo ""

# 步骤 5: 验证安装
echo -e "${BLUE}步骤 5/5: 验证安装${NC}"
echo ""

ERRORS=0

# 检查 skills
if [ -f ~/.claude/skills/daily-driver/SKILL.md ]; then
    echo -e "${GREEN}✅ daily-driver skill${NC}"
else
    echo -e "${YELLOW}❌ daily-driver skill 未找到${NC}"
    ERRORS=$((ERRORS + 1))
fi

if [ -f ~/.claude/skills/task-worker/SKILL.md ]; then
    echo -e "${GREEN}✅ task-worker skill${NC}"
else
    echo -e "${YELLOW}❌ task-worker skill 未找到${NC}"
    ERRORS=$((ERRORS + 1))
fi

# 检查知识库结构
if [ -d "$KNOWLEDGE_BASE/learning" ]; then
    echo -e "${GREEN}✅ learning/ 目录${NC}"
else
    echo -e "${YELLOW}❌ learning/ 目录未创建${NC}"
    ERRORS=$((ERRORS + 1))
fi

if [ -d "$KNOWLEDGE_BASE/life" ]; then
    echo -e "${GREEN}✅ life/ 目录${NC}"
else
    echo -e "${YELLOW}❌ life/ 目录未创建${NC}"
    ERRORS=$((ERRORS + 1))
fi

if [ -d "$KNOWLEDGE_BASE/work" ]; then
    echo -e "${GREEN}✅ work/ 目录${NC}"
else
    echo -e "${YELLOW}❌ work/ 目录未创建${NC}"
    ERRORS=$((ERRORS + 1))
fi

if [ -d "$KNOWLEDGE_BASE/others/daily" ]; then
    echo -e "${GREEN}✅ others/daily/ 目录${NC}"
else
    echo -e "${YELLOW}❌ others/daily/ 目录未创建${NC}"
    ERRORS=$((ERRORS + 1))
fi

if [ -f "$KNOWLEDGE_BASE/CLAUDE.md" ]; then
    echo -e "${GREEN}✅ CLAUDE.md${NC}"
else
    echo -e "${YELLOW}❌ CLAUDE.md 未创建${NC}"
    ERRORS=$((ERRORS + 1))
fi

echo ""

# 完成报告
echo "====================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}🎉 安装完成！${NC}"
    echo ""
    echo "📍 知识库位置: $KNOWLEDGE_BASE"
    echo "🧠 Skills 位置: ~/.claude/skills/"
    echo ""
    echo "📂 已创建的结构："
    echo "   ├── CLAUDE.md（项目指导）"
    echo "   ├── learning/"
    echo "   ├── life/"
    echo "   ├── work/"
    echo "   └── others/"
    echo "       └── daily/"
    echo "           ├── _Idea-Parking-Lot.md（想法停车场）"
    echo "           └── _QuickStart-Guide.md（快速上手指南）"
    echo ""
    echo -e "${BLUE}🚀 试试说：开启今天的工作${NC}"
else
    echo -e "${YELLOW}⚠️  安装完成，但有 $ERRORS 个问题${NC}"
    echo "请查看上方的错误信息。"
fi
echo "====================================="
