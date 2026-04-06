#!/usr/bin/env bash
# Minimal Skill Scripts Test Suite

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.claude/skills/daily-driver/scripts"
TWORKER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.claude/skills/task-worker/scripts"

echo "DEBUG: SCRIPT_DIR=$SCRIPT_DIR"
echo "DEBUG: TWORKER_DIR=$TWORKER_DIR"

ERRORS=0

run_test() {
    local desc="$1"
    shift
    if "$@"; then
        echo "  ✅ $desc"
    else
        echo "  ❌ $desc (exit $?)"
        ERRORS=$((ERRORS + 1))
    fi
}

echo "--- OS Utils ---"
run_test "detect_os.sh" "$SCRIPT_DIR/detect_os.sh"
run_test "get_yesterday_date.sh" "$SCRIPT_DIR/get_yesterday_date.sh"

echo ""
echo "--- Task Operations ---"
TEMP_TASK="/tmp/test_task_$$"
mkdir -p "$TEMP_TASK"
run_test "create_task.sh" "$SCRIPT_DIR/create_task.sh" MTEST test 'goal' 'deliverable'
run_test "check_today_exists.sh" "$SCRIPT_DIR/check_today_exists.sh"
run_test "create_today_folder.sh" "$SCRIPT_DIR/create_today_folder.sh"
rm -rf "$TEMP_TASK"

echo ""
echo "--- File Updates ---"
echo "old" > /tmp/test_update.txt
run_test "update_task_status.sh" "$SCRIPT_DIR/update_task_status.sh" /tmp/test_update.txt old NEW

echo "**最后更新**: old" > /tmp/test_time.txt
run_test "update_last_modified.sh" "$SCRIPT_DIR/update_last_modified.sh" /tmp/test_time.txt

echo ""
echo "--- daily-driver scripts ---"
echo "test" > /tmp/test_finding.txt
run_test "append_finding.sh" "$SCRIPT_DIR/append_finding.sh" /tmp/test_finding.txt title source content insight action

echo "test" > /tmp/test_session.txt
run_test "append_session_to_progress.sh" "$SCRIPT_DIR/append_session_to_progress.sh" /tmp/test_session.txt 2026-04-02

"$SCRIPT_DIR/continue_tasks.sh" M1 2>/dev/null || true

echo ""
echo "--- task-worker scripts ---"
echo "⏸ 进行中" > /tmp/test_complete.txt
run_test "mark_complete.sh" "$TWORKER_DIR/mark_complete.sh" /tmp/test_complete.txt

echo "done" > /tmp/test_prog.txt
run_test "append_progress.sh" "$TWORKER_DIR/append_progress.sh" /tmp/test_prog.txt done desc status

echo "error" > /tmp/test_plan.txt
run_test "append_error.sh" "$TWORKER_DIR/append_error.sh" /tmp/test_plan.txt /tmp/test_prog.txt error 1 solution

# Cleanup
rm -f /tmp/test_*.txt

echo ""
echo "==================================="
if [ $ERRORS -eq 0 ]; then
    echo "All tests passed! ✓"
else
    echo "FAILED: $ERRORS test(s) failed ✗"
    exit 1
fi
echo "==================================="
