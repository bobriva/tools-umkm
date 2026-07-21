_version_to_int() { local parts=(${1//./ }); echo $(( ${parts[0]:-0} * 10000 + ${parts[1]:-0} * 100 + ${parts[2]:-0} )); }
configure_go_path() {
    cat << 'GOPATH_EOF' > "/etc/profile.d/go.sh"
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
GOPATH_EOF
    chmod 644 "/etc/profile.d/go.sh"
    export GOPATH="$HOME/go"
    export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
    mkdir -p "$HOME/go/bin"
}
init_go_manager() {
    if command -v go >/dev/null 2>&1; then
        local cur; cur="$(go version | awk '{print $3}' | sed 's/go//')"
        if [[ $(_version_to_int "${cur}") -ge $(_version_to_int "${TARGET_GO_VERSION}") ]]; then
            configure_go_path; return 0
        fi
    fi
    local tar="go${TARGET_GO_VERSION}.linux-${OS_ARCH}.tar.gz"
    local url="https://go.dev/dl/${tar}" cache="${CACHE_DIR}/${tar}"
    if [[ ! -f "${cache}" ]]; then
        start_spinner "Downloading Go ${TARGET_GO_VERSION}"
        retry_cmd 3 5 curl -fL -o "${cache}" "${url}" >/dev/null 2>&1
        stop_spinner 0 "Downloaded Go ${TARGET_GO_VERSION}"
    fi
    rm -rf /usr/local/go
    start_spinner "Installing Go ${TARGET_GO_VERSION}"
    tar -C /usr/local -xzf "${cache}" >/dev/null 2>&1
    configure_go_path
    stop_spinner 0 "Go ${TARGET_GO_VERSION} installed"
}
