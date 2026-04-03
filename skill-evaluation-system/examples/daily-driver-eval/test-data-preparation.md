---
name: daily-driver-test-data
description: Daily Driver Skill 测试数据准备和环境配置
version: 1.0
created: 2026-04-03
---

# Daily Driver Skill 测试数据准备

## 一、测试环境要求

### 1.1 文件系统结构
需要模拟以下目录结构:
```
/Users/Zhuanz/Projects/daily-driver-workspace/
└── others/
    └── daily/
        ├── _Idea-Parking-Lot.md
        ├── _QuickStart-Guide.md
        ├── 2026-04-02/  (昨天)
        │   ├── 2026-04-02.md
        │   ├── task_M1_已完成任务/
        │   │   ├── task_plan.md (状态: ✅ 完成)
        │   │   ├── findings.md
        │   │   └── progress.md
        │   └── task_M2_未完成任务/
        │   │   ├── task_plan.md (状态: ⏸ 进行中)
        │   │   ├── findings.md
        │   │   └── progress.md
        ├── 2026-04-01/  (两天前)
        │   ├── 2026-04-01.md
        │   └── task_M3_旧任务/
        │       ├── task_plan.md (状态: ⏸ 进行中)
        │       ├── findings.md
        │       └── progress.md
        └── 2026-04-03/  (今天 - 可能存在)
            ├── 2026-04-03.md
            └── task_MTEST_test/  (测试任务)
```

### 1.2 环境变量
```bash
export SKILL_DIR="${HOME}/.claude/skills/daily-driver"
export TEST_WORKSPACE="/Users/Zhuanz/Projects/daily-driver-workspace/daily-driver-eval-workspace"
export DAILY_DIR="${TEST_WORKSPACE}/others/daily"
```

---

## 二、测试数据类型

### 2.1 模拟历史数据
用于测试昨天未完成任务检测:

**已完成任务示例** (task_M1):
```markdown
# 任务计划:M1 - 已完成任务

**任务状态**: ✅ 完成
**创建时间**: 2026-04-02 09:00
**最后更新**: 2026-04-02 17:00

## 任务目标
完成一个示例任务用于测试

## 预期交付物
- task_plan.md
- findings.md
- progress.md

## 完成标准
- [x] 文件创建完成
- [x] 内容完整
- [x] 状态正确

## 执行阶段
### Phase 1: 创建文件
- [x] 创建 task_plan.md
- [x] 创建 findings.md
- [x] 创建 progress.md

## 下一步行动
已完成

## 当前障碍
无

## 错误记录
| Error | Attempt | Resolution |
|-------|---------|------------|
```

**未完成任务示例** (task_M2):
```markdown
# 任务计划:M2 - 未完成任务

**任务状态**: ⏸ 进行中
**创建时间**: 2026-04-02 14:00
**最后更新**: 2026-04-02 18:00

## 任务目标
测试未完成任务延续功能

## 预期交付物
- 完整的延续流程测试
- 状态保持验证

## 完成标准
- [x] 创建任务文件
- [ ] 延续测试完成
- [ ] 状态验证通过

## 执行阶段
### Phase 1: 初始化
- [x] 创建任务文件

### Phase 2: 执行中
- [ ] 继续执行

## 下一步行动
等待延续到今天继续

## 当前障碍
时间不足,需要明天继续

## 错误记录
| Error | Attempt | Resolution |
|-------|---------|------------|
```

---

### 2.2 想法停车场数据
```markdown
# 💡 想法停车场

暂存的想法和灵感,随时可以激活为任务

---

## 待处理想法

### 想法 1: 学习 Tauri 框架
- **添加时间**: 2026-04-01
- **来源**: 看到一篇介绍文章
- **优先级**: 高
- **下一步**: 创建任务开始学习

### 想法 2: 写技术博客
- **添加时间**: 2026-04-02
- **来源**: 想分享 daily-driver 的使用经验
- **优先级**: 中
- **下一步**: 规划博客大纲

### 想法 3: 整理项目文档
- **添加时间**: 2026-03-30
- **来源**: 项目需要更好的文档
- **优先级**: 低
- **下一步**: 列出需要整理的文档

---

## 已激活想法
(已转化为任务的从这里移除)
```

---

### 2.3 每日记录模板
```markdown
# 2026-04-02

## 主线任务
- M1: 已完成任务 (状态: ✅ 完成)
- M2: 未完成任务 (状态: ⏸ 进行中)

## 副线探索
无

## 今日新增想法
- 想法 4: 优化 daily-driver skill

## 完成总结
完成了 M1,M2 因时间不足未完成,需明天延续
```

---

## 三、测试场景数据准备

### 3.1 场景 A: 首次使用
**数据准备**: 无历史数据
**目的**: 测试完全新用户的体验

**准备步骤**:
```bash
# 清空历史数据
rm -rf "${DAILY_DIR}/2026-04-"*
rm -f "${DAILY_DIR}/_Idea-Parking-Lot.md"
```

---

### 3.2 场景 B: 有未完成任务
**数据准备**: 创建昨天的未完成任务
**目的**: 测试任务延续功能

**准备步骤**:
```bash
# 创建昨天目录
mkdir -p "${DAILY_DIR}/2026-04-02/task_M2_未完成任务"

# 创建未完成任务文件
cp templates/task_plan_incomplete.md "${DAILY_DIR}/2026-04-02/task_M2_未完成任务/task_plan.md"
cp templates/findings_template.md "${DAILY_DIR}/2026-04-02/task_M2_未完成任务/findings.md"
cp templates/progress_template.md "${DAILY_DIR}/2026-04-02/task_M2_未完成任务/progress.md"

# 创建昨天每日记录
cat > "${DAILY_DIR}/2026-04-02/2026-04-02.md" << 'EOF'
# 2026-04-02

## 主线任务
- M2: 未完成任务 (状态: ⏸ 进行中)

## 副线探索
无

## 今日新增想法
无
EOF
```

---

### 3.3 场景 C: 连续多天未使用
**数据准备**: 创建 4 天前的未完成任务
**目的**: 测试间隔多天后的处理

**准备步骤**:
```bash
# 创建 4 天前目录
mkdir -p "${DAILY_DIR}/2026-03-30/task_M3_旧任务"

# 创建旧任务文件(状态为进行中)
cp templates/task_plan_incomplete.md "${DAILY_DIR}/2026-03-30/task_M3_旧任务/task_plan.md"

# 修改日期
sed -i 's/2026-04-02/2026-03-30/g' "${DAILY_DIR}/2026-03-30/task_M3_旧任务/task_plan.md"
```

---

### 3.4 场景 D: 并行执行
**数据准备**: 今天文件夹已存在,有进行中任务
**目的**: 测试并行执行和"并行"关键词处理

**准备步骤**:
```bash
# 创建今天目录
mkdir -p "${DAILY_DIR}/2026-04-03/task_M1_正在执行"

# 创建进行中任务
cat > "${DAILY_DIR}/2026-04-03/task_M1_正在执行/task_plan.md" << 'EOF'
# 任务计划:M1 - 正在执行

**任务状态**: ⏸ 进行中
**创建时间**: 2026-04-03 09:00
**最后更新**: 2026-04-03 10:00
EOF

# 创建今天每日记录
cat > "${DAILY_DIR}/2026-04-03/2026-04-03.md" << 'EOF'
# 2026-04-03

## 主线任务
- M1: 正在执行 (状态: ⏸ 进行中)

## 副线探索
无

## 今日新增想法
无
EOF
```

---

## 四、测试数据生成脚本

### 4.1 完整数据生成脚本
创建 `setup-test-data.sh`:

```bash
#!/bin/bash
# Daily Driver Skill 测试数据生成脚本

set -e

# 配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_WORKSPACE="${SCRIPT_DIR}/.."
DAILY_DIR="${TEST_WORKSPACE}/others/daily"
TEMPLATES_DIR="${SCRIPT_DIR}/templates"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() {
    echo "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo "${RED}[ERROR]${NC} $1"
}

# 清理测试环境
clean_test_env() {
    log_info "清理测试环境..."
    rm -rf "${DAILY_DIR}"
    mkdir -p "${DAILY_DIR}"
    log_info "测试环境已清理"
}

# 创建基础文件
create_base_files() {
    log_info "创建基础文件..."
    
    # 创建想法停车场
    cat > "${DAILY_DIR}/_Idea-Parking-Lot.md" << 'EOF'
# 💡 想法停车场

暂存的想法和灵感,随时可以激活为任务

---

## 待处理想法

### 想法 1: 学习 Tauri 框架
- **添加时间**: 2026-04-01
- **来源**: 看到一篇介绍文章
- **优先级**: 高

### 想法 2: 写技术博客
- **添加时间**: 2026-04-02
- **来源**: 想分享 daily-driver 的使用经验
- **优先级**: 中
EOF

    log_info "基础文件已创建"
}

# 创建昨天的已完成任务
create_completed_task() {
    log_info "创建昨天的已完成任务 M1..."
    
    mkdir -p "${DAILY_DIR}/2026-04-02/task_M1_已完成任务"
    
    cat > "${DAILY_DIR}/2026-04-02/task_M1_已完成任务/task_plan.md" << 'EOF'
# 任务计划:M1 - 已完成任务

**任务状态**: ✅ 完成
**创建时间**: 2026-04-02 09:00
**最后更新**: 2026-04-02 17:00

## 任务目标
完成一个示例任务用于测试

## 完成标准
- [x] 文件创建完成
- [x] 内容完整
- [x] 状态正确
EOF

    log_info "已完成任务 M1 已创建"
}

# 创建昨天的未完成任务
create_incomplete_task() {
    log_info "创建昨天的未完成任务 M2..."
    
    mkdir -p "${DAILY_DIR}/2026-04-02/task_M2_未完成任务"
    
    cat > "${DAILY_DIR}/2026-04-02/task_M2_未完成任务/task_plan.md" << 'EOF'
# 任务计划:M2 - 未完成任务

**任务状态**: ⏸ 进行中
**创建时间**: 2026-04-02 14:00
**最后更新**: 2026-04-02 18:00

## 任务目标
测试未完成任务延续功能

## 完成标准
- [x] 创建任务文件
- [ ] 延续测试完成
- [ ] 状态验证通过

## 下一步行动
等待延续到今天继续
EOF

    cat > "${DAILY_DIR}/2026-04-02/task_M2_未完成任务/findings.md" << 'EOF'
# 研究发现:M2 - 未完成任务

## 关键发现
暂无发现
EOF

    cat > "${DAILY_DIR}/2026-04-02/task_M2_未完成任务/progress.md" << 'EOF'
# 进展日志:M2 - 未完成任务

## Session 1: 2026-04-02

### 14:00 - 任务初始化
- ✅ 创建 task_plan.md
- ✅ 创建 findings.md
- ✅ 创建 progress.md
- 📍 当前状态:进行中

---

## 下一步
1. 等待明天延续
EOF

    log_info "未完成任务 M2 已创建"
}

# 创建昨天的每日记录
create_yesterday_daily_record() {
    log_info "创建昨天的每日记录..."
    
    cat > "${DAILY_DIR}/2026-04-02/2026-04-02.md" << 'EOF'
# 2026-04-02

## 主线任务
- M1: 已完成任务 (状态: ✅ 完成)
- M2: 未完成任务 (状态: ⏸ 进行中)

## 副线探索
无

## 今日新增想法
无

## 完成总结
完成了 M1,M2 因时间不足未完成,需明天延续
EOF

    log_info "昨日记录已创建"
}

# 创建多天前的旧任务
create_old_task() {
    log_info "创建多天前的旧任务 M3..."
    
    mkdir -p "${DAILY_DIR}/2026-03-30/task_M3_旧任务"
    
    cat > "${DAILY_DIR}/2026-03-30/task_M3_旧任务/task_plan.md" << 'EOF'
# 任务计划:M3 - 旧任务

**任务状态**: ⏸ 进行中
**创建时间**: 2026-03-30 10:00
**最后更新**: 2026-03-30 18:00

## 任务目标
测试间隔多天后的处理

## 完成标准
- [x] 创建任务
- [ ] 完成执行

## 下一步行动
已间隔多天,需要处理
EOF

    cat > "${DAILY_DIR}/2026-03-30/2026-03-30.md" << 'EOF'
# 2026-03-30

## 主线任务
- M3: 旧任务 (状态: ⏸ 进行中)

## 完成总结
任务未完成,已间隔多天
EOF

    log_info "旧任务 M3 已创建"
}

# 创建今天的已存在任务(用于并行测试)
create_today_task() {
    log_info "创建今天的已存在任务(并行场景)..."
    
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

    log_info "今天任务已创建"
}

# 主函数
main() {
    local scenario="${1:-all}"
    
    log_info "Daily Driver Skill 测试数据生成"
    log_info "场景: ${scenario}"
    
    clean_test_env
    create_base_files
    
    case "${scenario}" in
        "all")
            create_completed_task
            create_incomplete_task
            create_yesterday_daily_record
            create_old_task
            ;;
        "first-time")
            # 首次使用场景 - 无历史数据
            log_info "首次使用场景 - 无历史数据"
            ;;
        "incomplete")
            create_incomplete_task
            create_yesterday_daily_record
            ;;
        "parallel")
            create_today_task
            ;;
        "gap-days")
            create_old_task
            ;;
        *)
            log_error "未知场景: ${scenario}"
            exit 1
            ;;
    esac
    
    log_info "测试数据生成完成!"
    log_info "数据位置: ${DAILY_DIR}"
}

# 运行
main "$@"
```

---

## 五、模板文件准备

### 5.1 任务计划模板
见 skill 原有模板文件。

### 5.2 发现记录模板
见 skill 原有模板文件。

### 5.3 进展日志模板
见 skill 原有模板文件。

---

## 六、数据验证清单

### 6.1 数据完整性检查
- [ ] 所有必需目录已创建
- [ ] 所有文件已创建
- [ ] 文件内容格式正确
- [ ] 状态字段准确

### 6.2 数据一致性检查
- [ ] 每日记录与任务状态一致
- [ ] 任务时间戳合理
- [ ] 文件命名规范

---

## 七、数据清理脚本

创建 `cleanup-test-data.sh`:

```bash
#!/bin/bash
# 清理测试数据

DAILY_DIR="/Users/Zhuanz/Projects/daily-driver-workspace/others/daily"

echo "清理测试数据..."
rm -rf "${DAILY_DIR}/2026-03-"*
rm -rf "${DAILY_DIR}/2026-04-02"
rm -rf "${DAILY_DIR}/2026-04-03/task_MTEST_"*

echo "测试数据已清理"
```

---

## 八、测试环境管理

### 8.1 重置环境
```bash
# 完全重置
./setup-test-data.sh clean
./setup-test-data.sh all
```

### 8.2 特定场景设置
```bash
# 首次使用场景
./setup-test-data.sh first-time

# 有未完成任务场景
./setup-test-data.sh incomplete

# 并行执行场景
./setup-test-data.sh parallel

# 间隔多天场景
./setup-test-data.sh gap-days
```

### 8.3 清理特定场景
```bash
# 清理所有测试数据
./cleanup-test-data.sh
```