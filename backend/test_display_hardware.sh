#!/system/bin/sh
set -u
sample='
Display.Mode{id=1, width=1080, height=2400, fps=60.0}
Display.Mode{id=2, width=1080, height=2400, fps=90.0}
Display.Mode{id=3, width=1080, height=2400, fps=120.0}
mActiveModeId=3
'
printf '%s\n' "$sample" | awk '/Display\\.Mode\\{/{id=$0;sub(/^.*id=/,"",id);sub(/[^0-9].*$/,"",id);w=$0;sub(/^.*width=/,"",w);sub(/[^0-9].*$/,"",w);h=$0;sub(/^.*height=/,"",h);sub(/[^0-9].*$/,"",h);r=$0;sub(/^.*fps=/,"",r);sub(/[^0-9.].*$/,"",r);if(id==""||w==""||h==""||r=="")exit 1;count++} /mActiveModeId=/{a=$0;sub(/^.*mActiveModeId=/,"",a);sub(/[^0-9].*$/,"",a)} END{if(count!=3||a!="3")exit 1;print "PASS: supported=3 active_mode=3"}'
