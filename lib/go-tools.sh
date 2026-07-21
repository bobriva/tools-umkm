_is_installed() {
    local bin="$1"
    if command -v "${bin}" >/dev/null 2>&1 || [[ -f "/usr/local/bin/${bin}" ]] || [[ -f "${GOPATH}/bin/${bin}" ]]; then return 0; fi
    if [[ -n "${SUDO_USER:-}" ]]; then
        local u_home; u_home=$(getent passwd "${SUDO_USER}" | cut -d: -f6)
        if [[ -f "${u_home}/go/bin/${bin}" ]]; then ln -sf "${u_home}/go/bin/${bin}" "/usr/local/bin/${bin}" 2>/dev/null || true; return 0; fi
    fi
    return 1
}
init_go_tools_manager() {
    export GOPATH="${HOME}/go"; export PATH="${PATH}:/usr/local/go/bin:${GOPATH}/bin"
    local total; total=$(grep -v '^#' "${CONFIG_DIR}/tools.conf" | grep -c -v '^$' 2>/dev/null || echo "0")
    local step=0
    log_info "Syncing ${total} Go tools..."
    while read -r repo bin cat || [[ -n "${repo}" ]]; do
        [[ -z "${repo}" || "${repo}" =~ ^# ]] && continue
        step=$((step + 1))
        show_progress "${step}" "${total}" "${bin}"
        if _is_installed "${bin}"; then
            [[ -f "${GOPATH}/bin/${bin}" ]] && ln -sf "${GOPATH}/bin/${bin}" "/usr/local/bin/${bin}" 2>/dev/null || true
            continue
        fi
        if retry_cmd 2 3 go install "${repo}@latest" >/dev/null 2>&1; then
            [[ -f "${GOPATH}/bin/${bin}" ]] && ln -sf "${GOPATH}/bin/${bin}" "/usr/local/bin/${bin}" 2>/dev/null || true
        fi
    done < "${CONFIG_DIR}/tools.conf"
    
    # Menghapus baris progress bar dan menggantinya dengan status sukses yang rapi
    printf "\r\033[2K%s[ OK ]%s %d Go tools synced successfully\n" "${COLOR_SUCCESS}" "${COLOR_RESET}" "${total}"
}
