init_nuclei_manager() {
    if command -v nuclei >/dev/null 2>&1 || [[ -f "/usr/local/bin/nuclei" ]]; then
        local n_bin; n_bin="$(command -v nuclei 2>/dev/null || echo "/usr/local/bin/nuclei")"
        start_spinner "Updating Nuclei CVE templates"
        retry_cmd 2 5 "${n_bin}" -update-templates -silent >/dev/null 2>&1 || true
        stop_spinner 0 "Nuclei CVE templates updated"
    fi
}
