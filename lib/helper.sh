SPINNER_PID=""

_loader_loop() {
    local chars=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    while true; do
        for c in "${chars[@]}"; do
            sleep 0.08
            printf "\r\033[2K%s[PROG]%s %s %s%s%s" "${COLOR_INFO}" "${COLOR_RESET}" "$1" "${COLOR_INFO}" "${c}" "${COLOR_RESET}"
        done
    done
}

start_spinner() {
    tput civis 2>/dev/null || true
    _loader_loop "$1" &
    SPINNER_PID=$!
}

stop_spinner() {
    local status="$1"
    local msg="$2"
    if [[ -n "${SPINNER_PID}" ]] && kill -0 "${SPINNER_PID}" 2>/dev/null; then
        kill "${SPINNER_PID}" 2>/dev/null || true
        wait "${SPINNER_PID}" 2>/dev/null || true
    fi
    SPINNER_PID=""
    tput cnorm 2>/dev/null || true
    if [[ "${status}" -eq 0 ]]; then
        printf "\r\033[2K%s[ OK ]%s %s\n" "${COLOR_SUCCESS}" "${COLOR_RESET}" "${msg}"
    else
        printf "\r\033[2K%s[FAIL]%s %s\n" "${COLOR_ERROR}" "${COLOR_RESET}" "${msg}"
    fi
}

retry_cmd() {
    local max="$1"
    local delay="$2"
    shift 2
    local count=1
    while true; do
        if "$@"; then return 0; else
            local code=$?
            if [[ ${count} -lt ${max} ]]; then
                sleep "${delay}"; count=$((count + 1))
            else return ${code}; fi
        fi
    done
}

show_progress() {
    local current="$1"
    local total="$2"
    local task="$3"
    local width=22
    local pct=$((current * 100 / total))
    local comp=$((width * current / total))
    if [[ "${current}" -ge "${total}" ]]; then comp=${width}; pct=100; fi
    local rem=$((width - comp))
    
    # Hanya dicetak di baris yang sama tanpa echo "" agar baris progress bisa dihapus saat selesai
    printf "\r\033[2K%s[PROG]%s [%-${width}s] %3d%% | %s" "${COLOR_INFO}" "${COLOR_RESET}" "$(printf "%0.s█" $(seq 1 $comp 2>/dev/null) ; printf "%0.s░" $(seq 1 $rem 2>/dev/null))" "${pct}" "${task}"
}
