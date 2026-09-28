#!/system/bin/sh
set -u
DIR="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)"
exec "$DIR/select_payload.sh"
