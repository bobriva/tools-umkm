if [[ -t 1 ]]; then
    COLOR_RESET=$'\033[0m'
    COLOR_INFO=$'\033[1;36m'    # Cyan Terang
    COLOR_SUCCESS=$'\033[1;32m' # Hijau Terang
    COLOR_WARN=$'\033[1;33m'    # Kuning Terang
    COLOR_ERROR=$'\033[1;31m'   # Merah Terang
    COLOR_DIM=$'\033[2;37m'     # Redup
    COLOR_BOLD=$'\033[1m'       # Tebal
else
    COLOR_RESET="" COLOR_INFO="" COLOR_SUCCESS="" COLOR_WARN="" COLOR_ERROR="" COLOR_DIM="" COLOR_BOLD=""
fi

_log() {
    local level="$1"
    local color="$2"
    shift 2
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [${level}] $*" >> "${LOG_FILE:-logs/install.log}"
    echo -e "${color}[${level}]${COLOR_RESET} $*"
}

log_info()    { _log "INFO" "${COLOR_INFO}" "$@"; }
log_success() { _log "SUCCESS" "${COLOR_SUCCESS}" "$@"; }
log_warn()    { _log "WARN" "${COLOR_WARN}" "$@"; }
log_error()   { _log "ERROR" "${COLOR_ERROR}" "$@"; }
