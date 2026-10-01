# Reusable Bash functions. Source this file; do not execute it directly.

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >&2
}

die() {
  local message="$1"
  local status="${2:-1}"

  printf 'Error: %s\n' "$message" >&2
  exit "$status"
}

require_file() {
  local path="$1"

  [[ -f "$path" ]] || die "Required file not found: $path" 2
}
