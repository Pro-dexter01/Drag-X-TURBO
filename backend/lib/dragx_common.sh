#!/system/bin/sh
# Drag X TURBO shared backend conventions.
# Step 3A foundation: no component-specific mutations belong here.

set -u

DRAGX_RESULT_OK=0
DRAGX_RESULT_FALLBACK=3
DRAGX_RESULT_UNSUPPORTED=4
DRAGX_RESULT_ERROR=5

dragx_result() {
  component="$1"
  action="$2"
  status="$3"
  reason="$4"
  printf 'RESULT|component=%s|action=%s|status=%s|reason=%s\n' "$component" "$action" "$status" "$reason"
}

dragx_has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

dragx_is_root() {
  [ "$(id -u 2>/dev/null || printf 1)" = "0" ]
}

dragx_getprop() {
  getprop "$1" 2>/dev/null || true
}

dragx_abi() {
  value="$(dragx_getprop ro.product.cpu.abi)"
  [ -n "$value" ] || value="$(dragx_getprop ro.product.cpu.abilist | cut -d, -f1)"
  printf '%s\n' "$value"
}

dragx_supports_root() {
  dragx_is_root
}

dragx_supports_cmd() {
  dragx_has_cmd "$1"
}

# Components should return one of:
# READ_ONLY / BOUNDED / PERSISTENT / DESTRUCTIVE
dragx_safety_allowed() {
  class="$1"
  case "$class" in
    READ_ONLY|BOUNDED) return 0 ;;
    PERSISTENT|DESTRUCTIVE) return 1 ;;
    *) return 1 ;;
  esac
}
