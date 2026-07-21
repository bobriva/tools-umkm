OS_NAME="" OS_ARCH=""
detect_os() {
    if [[ -f /etc/os-release ]]; then source /etc/os-release; OS_NAME="${ID:-unknown}"; else exit 1; fi
    if ! command -v apt >/dev/null 2>&1; then log_error "APT not found."; exit 1; fi
}
detect_arch() {
    case "$(uname -m)" in
        x86_64) OS_ARCH="amd64" ;; aarch64|arm64) OS_ARCH="arm64" ;; *) exit 1 ;;
    esac
    log_info "System: ${OS_NAME} (${OS_ARCH})"
}
init_os_detection() { detect_os; detect_arch; }
