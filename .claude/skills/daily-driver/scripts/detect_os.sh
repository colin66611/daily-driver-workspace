#!/usr/bin/env bash
# OS detection utility - returns: macOS, Windows, or Linux

case "$(uname -s)" in
    Darwin*)    echo "macOS" ;;
    Linux*)     echo "Linux" ;;
    CYGWIN*)    echo "Cygwin" ;;
    MINGW*|MSYS*) echo "Windows" ;;
    *)          echo "Linux" ;;
esac
