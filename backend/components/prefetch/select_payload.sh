#!/system/bin/sh
set -u
PAYLOAD_DIR="/system/bin"
result() { printf 'RESULT|component=prefetch|action=%s|status=%s|reason=%s\n' "$1" "$2" "$3"; }
sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1" | awk '{print $1}'; return; fi
  if command -v toybox >/dev/null 2>&1; then toybox sha256sum "$1" | awk '{print $1}'; return; fi
  printf ''
}
abi="$(getprop ro.product.cpu.abi 2>/dev/null || true)"
[ -n "$abi" ] || abi="$(getprop ro.product.cpu.abilist 2>/dev/null | cut -d, -f1 || true)"
case "$abi" in
  arm64-v8a|aarch64)
    gap="GAP64"; vmtouch="vmtouch64"
    expected_gap="cb64fcc3742cb5534605189a1d1e5309294cfd2825ce206581ad745eb11be488"
    expected_vmtouch="05caac082fcfa1d6b5702f1128d3c9ada04e4e9acdbac83e1297d4ab6edfa850" ;;
  armeabi-v7a|armeabi|arm)
    gap="GAP32"; vmtouch="vmtouch32"
    expected_gap="0464adac4a65b00e31de7fab33c0cc5426a7335f28d3941f37ac12314478c753"
    expected_vmtouch="a73edcc661e59b169e99f52a08e8d8b26c78beeb7c69ff0bf1d1675fbc7c392f" ;;
  *) result select unsupported "abi=$abi"; exit 4 ;;
esac
verify_one() {
  name="$1"; expected="$2"; path="$PAYLOAD_DIR/$name"
  [ -f "$path" ] || { result "verify-$name" fallback missing-payload; return 3; }
  [ -x "$path" ] || { result "verify-$name" error not-executable; return 5; }
  actual="$(sha256_of "$path")"
  [ -n "$actual" ] || { result "verify-$name" unsupported sha256-unavailable; return 4; }
  [ "$actual" = "$expected" ] || { result "verify-$name" error sha256-mismatch; return 5; }
  result "verify-$name" ok sha256-match
}
verify_one "$gap" "$expected_gap" || exit $?
verify_one "$vmtouch" "$expected_vmtouch" || exit $?
result select ok "abi=$abi|gap=$gap|vmtouch=$vmtouch"
printf '%s|%s\n' "$gap" "$vmtouch"
