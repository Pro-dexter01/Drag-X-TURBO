#!/system/bin/sh
# Drag X TURBO - hardware-aware display/FPS backend
set -u
ACTION="${1:-status}"
REQUEST="${2:-}"
DISPLAY_ID="${3:-0}"
case "$ACTION" in
  status)
    dumpsys display 2>/dev/null | awk '/mActiveModeId=/{a=$0; sub(/^.*mActiveModeId=/,"",a); sub(/[^0-9].*$/,"",a); print "ACTIVE|" a} /Display\\.Mode\\{/{id=$0;sub(/^.*id=/,"",id);sub(/[^0-9].*$/,"",id);w=$0;sub(/^.*width=/,"",w);sub(/[^0-9].*$/,"",w);h=$0;sub(/^.*height=/,"",h);sub(/[^0-9].*$/,"",h);r=$0;sub(/^.*fps=/,"",r);if(r==$0){r=$0;sub(/^.*refreshRate=/,"",r)}sub(/[^0-9.].*$/,"",r);if(id!=""&&w!=""&&h!=""&&r!="")print "MODE|" id "|" w "|" h "|" r}'
    ;;
  *)
    echo "error=unsupported_action"
    exit 2
    ;;
esac
