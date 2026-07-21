#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -f "${SCRIPT_DIR}/config/settings.conf" ]]; then echo "Config not found." >&2; exit 1; fi
source "${SCRIPT_DIR}/config/settings.conf"

if [[ "$EUID" -ne 0 ]]; then echo "[ERROR] Run with: sudo ./install.sh" >&2; exit 1; fi

cleanup() {
    if declare -f stop_spinner >/dev/null && [[ -n "${SPINNER_PID:-}" ]]; then stop_spinner 1 "Stopped" 2>/dev/null || true; fi
    tput cnorm 2>/dev/null || true
    rm -rf "${TMP_DIR}"/* 2>/dev/null || true
}
trap cleanup EXIT INT TERM

main() {
    mkdir -p "${LOG_DIR}" "${TMP_DIR}" "${CACHE_DIR}"
    for mod in logger.sh banner.sh helper.sh os.sh apt.sh go.sh go-tools.sh python.sh nuclei.sh summary.sh; do
        source "${LIB_DIR}/${mod}"
    done
    
    show_banner
    init_os_detection
    init_apt_manager
    init_go_manager
    init_go_tools_manager
    init_python_manager
    init_nuclei_manager
    init_summary_report
}
main "$@"
