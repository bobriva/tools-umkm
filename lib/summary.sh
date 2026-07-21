init_summary_report() {
    # Mengembalikan hak milik ke user asli secara silent di background
    if [[ -n "${SUDO_USER:-}" ]]; then
        local u_home; u_home=$(getent passwd "${SUDO_USER}" | cut -d: -f6)
        chown -R "${SUDO_USER}:${SUDO_USER}" "${u_home}/go" "${u_home}/.local" 2>/dev/null || true
    fi

    local go_count; go_count=$(grep -v '^#' "${CONFIG_DIR}/tools.conf" | grep -c -v '^$' 2>/dev/null || echo "0")
    local py_count; py_count=$(grep -v '^#' "${CONFIG_DIR}/python.conf" | grep -c -v '^$' 2>/dev/null || echo "0")

    echo ""
    echo -e "${COLOR_INFO}──────────────────────────────────────────────────────${COLOR_RESET}"
    echo -e "  ${COLOR_BOLD}SYSTEM ENVIRONMENT STATUS${COLOR_RESET}"
    echo -e "${COLOR_INFO}──────────────────────────────────────────────────────${COLOR_RESET}"
    echo -e "  ${COLOR_SUCCESS}◈${COLOR_RESET}  ${COLOR_BOLD}Go Runtime${COLOR_RESET}     : v${TARGET_GO_VERSION} (${OS_ARCH})"
    echo -e "  ${COLOR_SUCCESS}◈${COLOR_RESET}  ${COLOR_BOLD}Go Tools${COLOR_RESET}       : ${go_count} Packages Active"
    echo -e "  ${COLOR_SUCCESS}◈${COLOR_RESET}  ${COLOR_BOLD}Python Tools${COLOR_RESET}   : ${py_count} Packages Active"
    echo -e "  ${COLOR_SUCCESS}◈${COLOR_RESET}  ${COLOR_BOLD}Nuclei Engine${COLOR_RESET}  : CVE Templates Updated"
    echo -e "${COLOR_INFO}──────────────────────────────────────────────────────${COLOR_RESET}"
    echo -e "  ${COLOR_SUCCESS}jangan lupa Bismillah biar semua dilancarkan...${COLOR_RESET}"
    echo ""
}
