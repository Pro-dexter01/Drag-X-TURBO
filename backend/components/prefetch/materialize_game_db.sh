#!/system/bin/sh
set -u
SRC="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)/game-db/gamelist.txt.gz.b64"
OUT="${1:-/data/local/tmp/dragx-gamelist.txt}"
if ! command -v base64 >/dev/null 2>&1 || ! command -v gzip >/dev/null 2>&1; then
  printf 'RESULT|component=prefetch|action=game-db|status=unsupported|reason=base64-or-gzip-unavailable\n'
  exit 4
fi
base64 -d "$SRC" 2>/dev/null | gzip -d > "$OUT" 2>/dev/null || {
  rm -f "$OUT"
  printf 'RESULT|component=prefetch|action=game-db|status=error|reason=decode-failed\n'
  exit 5
}
printf 'RESULT|component=prefetch|action=game-db|status=ok|reason=materialized|path=%s\n' "$OUT"
