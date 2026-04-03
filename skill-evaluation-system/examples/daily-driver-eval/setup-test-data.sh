#!/bin/bash
# Daily Driver Skill 测试数据快速生成脚本(简化版)

set -e

# 配置
DAILY_DIR="/Users/Zhuanz/Projects/daily-driver-workspace/others/daily"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo "${RED}[ERROR]${NC} $1"; }
log_step() { echo "${BLUE}[STEP]${NC} $1"; }

# 清理环境
clean_env() {
    log_step "清理测试环境..."
    rm -rf "${DAILY_DIR}/2026-03-"*
    rm -rf "${DAILY_DIR}/2026-04-02"
    rm -rf "${DAILY_DIR}/2026-04-03/task_MTEST_"*
    log_info "环境已清理"
}

# 创建想法停车场
create_parking_lot() {
    log_step "创建想法停车场..."
    cat > "${DAILY_DIR}/_Idea-Parking-Lot.md" << 'EOF'
# 💡 想法停车场

## 待处理想法

### 想法 1: 学习 Tauri 框架
- **优先级**: 高

### 想法 2: 写技术博客
- **优先级**: 中
EOF
    log_info "停车场已创建"
}

# 创建昨天的未完成任务
create_yesterday_incomplete() {
    log_step "创建昨天的未完成任务..."

    mkdir -p "${DAILY_DIR}/2026-04-02/task_M2_测试任务"

    cat > "${DAILY_DIR}/2026-04-02/task_M2_测试任务/task_plan.md" << 'EOF'
# 任务计划:M2 - 测试任务

**任务状态**: ⏸ 进行中
**创建时间**: 2026-04-02 14:00
**最后更新**: 2026-04-02 18:00

## 任务目标
测试未完成任务延续功能

## 完成标准
- [x] 创建任务文件
- [ ] 延续测试完成

## 下一步行动
等待延续到今天继续
EOF

    cat > "${DAILY_DIR}/2026-04-02/2026-04-02.md" << 'EOF'
# 2026-04-02

## 主线任务
- M2: 测试任务 (状态: ⏸ 进行中)
EOF

    log_info "昨天的未完成任务已创建"
}

# 创建多天前的旧任务
create_old_task() {
    log_step "创建多天前的旧任务..."

    mkdir -p "${DAILY_DIR}/2026-03-30/task_M3_旧任务"

    cat > "${DAILY_DIR}/2026-03-30/task_M3_旧任务/task_plan.md" << 'EOF'
# 任务计划:M3 - 旧任务

**任务状态**: ⏸ 进行中
**创建时间**: 2026-03-30 10:00
**最后更新**: 2026-03-30 18:00

## 任务目标
测试间隔多天后的处理

## 下一步行动
已间隔多天,需要处理
EOF

    cat > "${DAILY_DIR}/2026-03-30/2026-03-30.md" << 'EOF'
# 2026-03-30

## 主线任务
- M3: 旧任务 (状态: ⏸ 进行中)
EOF

    log_info "多天前的旧任务已创建"
}

# 创建今天已有任务(并行场景)
create_today_existing() {
    log_step "创建今天的已有任务(并行场景)..."

    mkdir -p "${DAILY_DIR}/2026-04-03/task_M1_正在执行"

    cat > "${DAILY_DIR}/2026-04-03/task_M1_正在执行/task_plan.md" << 'EOF'
# 任务计划:M1 - 正在执行

**任务状态**: ⏸ 进行中
**创建时间**: 2026-04-03 09:00
**最后更新**: 2026-04-03 10:00

## 任务目标
测试并行执行场景

## 完成标准
- [x] 任务创建
- [ ] 执行完成
EOF

    cat > "${DAILY_DIR}/2026-04-03/2026-04-03.md" << 'EOF'
# 2026-04-03

## 主线任务
- M1: 正在执行 (状态: ⏸ 进行中)

## 副线探索
无

## 今日新增想法
无
EOF

    log_info "今天的已有任务已创建"
}

# 显示帮助
show_help() {
    echo "Daily Driver Skill 测试数据生成脚本"
    echo ""
    echo "用法: $0 <场景>"
    echo ""
    echo "可用场景:"
    echo "  all           - 创建所有测试数据(默认)"
    echo "  first-time    - 首次使用场景(无历史数据)"
    echo "  incomplete    - 有未完成任务场景"
    echo "  parallel      - 并行执行场景"
    echo "  gap-days      - 间隔多天场景"
    echo "  clean         - 仅清理环境"
    echo ""
    echo "示例:"
    echo "  $0 incomplete   # 创建昨天的未完成任务"
    echo "  $0 parallel     # 创建今天的已有任务"
    echo "  $0 clean        # 清理所有测试数据"
}

# 主函数
main() {
    local scenario="${1:-all}"

    log_info "Daily Driver Skill 测试数据生成"
    log_info "场景: ${scenario}"

    case "${scenario}" in
        "all")
            clean_env
            create_parking_lot
            create_yesterday_incomplete
            create_old_task
            log_info "✅ 所有测试数据已创建"
            ;;
        "first-time")
            clean_env
            create_parking_lot
            log_info "✅ 首次使用场景已准备"
            ;;
        "incomplete")
            clean_env
            create_parking_lot
            create_yesterday_incomplete
            log_info "✅ 未完成任务场景已准备"
            ;;
        "parallel")
            clean_env
            create_parking_lot
            create_today_existing
            log_info "✅ 并行执行场景已准备"
            ;;
        "gap-days")
            clean_env
            create_parking_lot
            create_old_task
            log_info "✅ 间隔多天场景已准备"
            ;;
        "clean")
            clean_env
            log_info "✅ 环境已清理"
            ;;
        "-h"|"--help"|"help")
            show_help
            exit 0
            ;;
        *)
            log_error "未知场景: ${scenario}"
            show_help
            exit 1
            ;;
    esac

    log_info "数据位置: ${DAILY_DIR}"
}

main "$@"