#!/system/bin/sh
set -u
ACTION="${1:-status}"
REQUEST="${2:-}"
DISPLAY_ID="${3:-0}"
parse_modes() {
  dumpsys display 2>/dev/null | awk '/Display\\.Mode\\{/{id=$0;sub(/^.*id=/,"",id);sub(/[^0-9].*$/,"",id);w=$0;sub(/^.*width=/,"",w);sub(/[^0-9].*$/,"",w);h=$0;sub(/^.*height=/,"",h);sub(/[^0-9].*$/,"",h);r=$0;sub(/^.*fps=/,"",r);if(r==$0){r=$0;sub(/^.*refreshRate=/,"",r)}sub(/[^0-9.].*$/,"",r);if(id!=""&&w!=""&&h!=""&&r!="")print "MODE|"id"|"w"|"h"|"r}'
}
active_mode() { dumpsys display 2>/dev/null | awk -F'mActiveModeId=' 'NF>1{v=$2;sub(/[^0-9].*/,"",v); if(v!="") print v; exit}' ; }
case "$ACTION" in
 status)
   echo "ACTIVE|$(active_mode)"
   parse_modes
   ;;
 apply)
   [ -n "$REQUEST" ] || { echo 'ERROR|missing_request'; exit 2; }
   modes="$(parse_modes)"
   mode_id="$(printf '%s\\n' "$modes" | awk -F'|' -v r="$REQUEST" '$1=="MODE" && ($5+0)==(r+0){print $2; exit}')"
   if [ -z "$mode_id" ]; then echo "FALLBACK|requested=$REQUEST|reason=unsupported"; exit 3; fi
   if cmd display help 2>&1 | grep -q 'set-user-preferred-display-mode'; then
      cmd display set-user-preferred-display-mode "$DISPLAY_ID" "$mode_id" >/dev/null 2>&1 || true
   elif cmd display help 2>&1 | grep -q 'set-match-content-frame-rate-pref'; then
      cmd display set-match-content-frame-rate-pref "$DISPLAY_ID" "$REQUEST" >/dev/null 2>&1 || true
   else
      echo "FALLBACK|requested=$REQUEST|reason=no_display_control"; exit 4
   fi
   sleep 1
   active="$(active_mode)"
   active_rate="$(printf '%s\\n' "$modes" | awk -F'|' -v id="$active" '$1=="MODE"&&$2==id{print $5;exit}')"
   if [ "${active_rate%.*}" = "${REQUEST%.*}" ]; then echo "VERIFIED|requested=$REQUEST|active=$active_rate|mode=$active"; else echo "FALLBACK|requested=$REQUEST|active=${active_rate:-unknown}|mode=${active:-unknown}"; fi
   ;;
 *) echo 'ERROR|unsupported_action'; exit 2;;
esac
