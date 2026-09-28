#!/system/bin/sh
MODDIR=${0%/*}
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done
mkdir -p /data/local/tmp/dragx_turbo
"$MODDIR/system/bin/dragxctl" boot >/data/local/tmp/dragx_turbo/boot.log 2>&1
exit 0
