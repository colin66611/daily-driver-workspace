#!/bin/bash
# Skill评估一键运行脚本

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo "${RED}[ERROR]${NC} $1"; }
log_step() { echo "${BLUE}[STEP]${NC} $1"; }

# 参数检查
WORKSPACE="${1}"
SKILL_NAME="${2:-}"

if [ -z "$WORKSPACE" ]; then
    echo "Usage: $0 <workspace-dir> [skill-name]"
    echo "Example: $0 my-skill-eval my-skill"
    exit 1
fi

# 检查workspace是否存在
if [ ! -d "$WORKSPACE" ]; then
    log_error "Workspace directory not found: $WORKSPACE"
    exit 1
fi

# 检查evals.json
if [ ! -f "$WORKSPACE/evals.json" ]; then
    log_error "evals.json not found in $WORKSPACE"
    log_info "Please create evals.json first. See templates/evals_template.json"
    exit 1
fi

# 推断skill名称
if [ -z "$SKILL_NAME" ]; then
    SKILL_NAME=$(basename "$WORKSPACE" | sed 's/-eval$//')
    log_warn "Skill name not specified, inferred: $SKILL_NAME"
fi

log_info "==================================="
log_info "Skill Evaluation System"
log_info "==================================="
log_info "Workspace: $WORKSPACE"
log_info "Skill: $SKILL_NAME"
log_info "==================================="

# 检查skill是否存在
SKILL_PATH=".claude/skills/$SKILL_NAME"
if [ ! -d "$SKILL_PATH" ]; then
    log_warn "Skill directory not found: $SKILL_PATH"
    log_info "Make sure the skill is installed before running evaluation"
fi

# 创建iteration目录
ITERATION=1
ITER_DIR="$WORKSPACE/iteration-$ITERATION"
mkdir -p "$ITER_DIR"
log_step "Created iteration directory: $ITER_DIR"

# 读取evals数量
EVAL_COUNT=$(cat "$WORKSPACE/evals.json" | python3 -c "import sys, json; print(len(json.load(sys.stdin)['evals']))")
log_info "Found $EVAL_COUNT evaluation cases"

log_step "Starting evaluation..."
log_info "This will run $((EVAL_COUNT * 2)) sub-agents in parallel"
log_info "Estimated time: 5-30 minutes"

# 调用Claude执行评估
log_step "Launching Claude with skill-creator..."
log_info "Claude will automatically:"
log_info "  1. Launch all test sub-agents"
log_info "  2. Collect timing data"
log_info "  3. Generate benchmark"
log_info "  4. Open visualization viewer"

# 提示用户下一步
log_info ""
log_info "==================================="
log_info "NEXT STEPS:"
log_info "==================================="
log_info "1. Tell Claude: 'Use skill-creator to evaluate this skill'"
log_info "2. Point Claude to: $WORKSPACE/evals.json"
log_info "3. Wait for auto-generated viewer"
log_info "4. Review results and provide feedback"
log_info "==================================="
log_info ""
log_info "After evaluation, check:"
log_info "  - Benchmark: $ITER_DIR/benchmark.json"
log_info "  - Detailed outputs: $ITER_DIR/eval-*/"
log_info ""
log_info "Good luck! 🎯"