#!/usr/bin/env bash
# Get yesterday's date in YYYY-MM-DD format (cross-platform)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_TYPE=$("$SCRIPT_DIR/detect_os.sh")

case "$OS_TYPE" in
    macOS)
        date -v-1d '+%Y-%m-%d'
        ;;
    Windows|Linux|*)
        date -d 'yesterday' '+%Y-%m-%d' 2>/dev/null || \
        python3 -c "from datetime import date, timedelta; print((date.today() - timedelta(1)).isoformat())"
        ;;
esac
