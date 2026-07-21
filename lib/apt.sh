init_apt_manager() {
    local missing=()
    while IFS= read -r pkg || [[ -n "${pkg}" ]]; do
        [[ -z "${pkg}" || "${pkg}" =~ ^# ]] && continue
        if ! dpkg-query -W -f='${Status}' "${pkg}" 2>/dev/null | grep -q "install ok installed"; then
            missing+=("${pkg}")
        fi
    done < "${CONFIG_DIR}/apt.conf"
    if [[ ${#missing[@]} -eq 0 ]]; then return 0; fi
    log_info "Installing ${#missing[@]} missing system packages..."
    apt-get update -qq >/dev/null 2>&1 || true
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "${missing[@]}" >/dev/null 2>&1 || true
}
