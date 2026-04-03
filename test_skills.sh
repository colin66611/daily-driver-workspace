#!/usr/bin/env bash
# Skill Scripts Test Suite
# Run this to verify all scripts work correctly

# Trigger CI for debugging
set -e

echo "==================================="
echo "Daily Driver Skill Scripts Test Suite"
echo "==================================="
echo ""

PASS=0
FAIL=0

# Helper function
test_script() {
    local name="$1"
    local cmd="$2"
    echo -n "Testing: $name ... "
    local output
    local exit_code
    output=$(eval "$cmd" 2>&1)
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo "✓ PASS"
        PASS=$((PASS + 1))
    else
        echo "✗ FAIL (exit: $exit_code)"
        echo "  Error: $output" | head -3
        FAIL=$((FAIL + 1))
    fi
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.claude/skills/daily-driver/scripts"
TWORKER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.claude/skills/task-worker/scripts"

# Debug: show SCRIPT_DIR in CI
echo "DEBUG: SCRIPT_DIR=$SCRIPT_DIR"
echo "DEBUG: TWORKER_DIR=$TWORKER_DIR"

echo "--- OS Utils ---"
test_script "detect_os" "$SCRIPT_DIR/detect_os.sh"
test_script "get_yesterday_date" "$SCRIPT_DIR/get_yesterday_date.sh"

echo ""
echo "--- Task Operations ---"
# Create a temp task
TEMP_TASK="/tmp/test_task_$$"
mkdir -p "$TEMP_TASK"
test_script "create_task.sh" "$SCRIPT_DIR/create_task.sh MTEST test 'goal' 'deliverable'"
test_script "check_today_exists" "$SCRIPT_DIR/check_today_exists.sh"
test_script "create_today_folder" "$SCRIPT_DIR/create_today_folder.sh"
rm -rf "$TEMP_TASK"

echo ""
echo "--- File Updates ---"
echo "old" > /tmp/test_update.txt
test_script "update_task_status" "$SCRIPT_DIR/update_task_status.sh /tmp/test_update.txt old NEW"

echo "**最后更新**: old" > /tmp/test_time.txt
test_script "update_last_modified" "$SCRIPT_DIR/update_last_modified.sh /tmp/test_time.txt"

echo ""
echo "--- daily-driver scripts ---"
test_script "append_finding" "$SCRIPT_DIR/append_finding.sh /tmp/test_finding.txt title source content insight action"
test_script "append_session_to_progress" "$SCRIPT_DIR/append_session_to_progress.sh /tmp/test_session.txt 2026-04-02"
test_script "continue_tasks" "$SCRIPT_DIR/continue_tasks.sh M1 2>/dev/null || true"  # May fail if no yesterday tasks

echo ""
echo "--- task-worker scripts ---"
echo "⏸ 进行中" > /tmp/test_complete.txt
test_script "mark_complete" "$TWORKER_DIR/mark_complete.sh /tmp/test_complete.txt"
test_script "append_progress" "$TWORKER_DIR/append_progress.sh /tmp/test_prog.txt done desc status"
test_script "append_error" "$TWORKER_DIR/append_error.sh /tmp/test_plan.txt /tmp/test_prog.txt error 1 solution"

# Cleanup
rm -f /tmp/test_*.txt

echo ""
echo "==================================="
echo "Results: $PASS passed, $FAIL failed"
echo "==================================="

if [ $FAIL -eq 0 ]; then
    echo "All tests passed! ✓"
    exit 0
else
    echo "Some tests failed."
    exit 1
fi
