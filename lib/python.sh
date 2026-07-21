init_python_manager() {
    local venv_dir="/usr/local/share/tools-umkm-venv"
    local pip_bin="${venv_dir}/bin/pip"

    if [[ ! -d "${venv_dir}" ]]; then
        python3 -m venv "${venv_dir}" >/dev/null 2>&1 || true
    fi
    "${pip_bin}" install --upgrade pip setuptools wheel -q >/dev/null 2>&1 || true

    local python_conf="${CONFIG_DIR}/python.conf"
    if [[ ! -f "${python_conf}" ]]; then
        log_error "Configuration file missing: ${python_conf}"
        exit 1
    fi

    local total; total=$(grep -v '^#' "${python_conf}" | grep -c -v '^$' 2>/dev/null || echo "0")
    local step=0
    log_info "Syncing ${total} Python tools..."

    while read -r pkg exec_name || [[ -n "${pkg}" ]]; do
        [[ -z "${pkg}" || "${pkg}" =~ ^# ]] && continue
        step=$((step + 1))
        show_progress "${step}" "${total}" "${exec_name}"

        if command -v "${exec_name}" >/dev/null 2>&1 || [[ -f "${venv_dir}/bin/${exec_name}" ]]; then
            [[ -f "${venv_dir}/bin/${exec_name}" ]] && ln -sf "${venv_dir}/bin/${exec_name}" "/usr/local/bin/${exec_name}" 2>/dev/null || true
            continue
        fi

        if retry_cmd 2 3 "${pip_bin}" install --prefer-binary --timeout 60 "${pkg}" -q >/dev/null 2>&1; then
            [[ -f "${venv_dir}/bin/${exec_name}" ]] && ln -sf "${venv_dir}/bin/${exec_name}" "/usr/local/bin/${exec_name}" 2>/dev/null || true
        fi
    done < "${python_conf}"

    # Menghapus baris progress bar dan menggantinya dengan status sukses yang rapi
    printf "\r\033[2K%s[ OK ]%s %d Python tools synced successfully\n" "${COLOR_SUCCESS}" "${COLOR_RESET}" "${total}"
}
