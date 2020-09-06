#!/system/bin/sh

## Mount YouTube Vanced over stock YouTube.
## ipdev @ xda-developers

## Requires YouTube to be installed as a user app.
## Required YouTube version is 15.33.34


# Module directory set by Magisk.
MODDIR=${0%/*}

# Required YT versionCode
RVCODE=1514395072

# Wait untill boot is compleate before moving on.
while [ "$(getprop sys.boot_completed)" != 1 ];
do sleep 1;
done;

# Get SDK level and architecture.
SDK=$(getprop ro.build.version.sdk);
# ARCH=$(getprop ro.product.cpu.abi);

# Find and set YouTube path.
if [ $SDK -ge 30 ]; then
	YTPATH=$(readlink -f /data/app/*/com.google.android.youtube*);
else
	YTPATH=$(readlink -f /data/app/com.google.android.youtube*);
fi;

# Find installed (active) YouTube versionCode
YTVCODE=$(dumpsys package com.google.android.youtube | grep versionCode | cut -f2 -d'=' | tr -d '\n' | cut -f1 -d' ')

# Check YouTube path and versionCode.
if [ ! -f $YTPATH/base.apk ]; then
	echo "$(date '+%Y%m%d_%H%M')" "No stock YouTube found." >>$MODDIR/error.log;
elif [ ! $YTVCODE = $RVCODE ]; then
	echo "$(date '+%Y%m%d_%H%M')" "Wrong version of YouTube found." >>$MODDIR/error.log;
else
	# if [ $SDK -ge 27 ]; then
	# 	su -c mount $MODDIR/base.apk $YTPATH/base.apk;
	# else
	# 	su -c mount -o bind $MODDIR/base.apk $YTPATH/base.apk;
	# fi;
	su -c mount -o bind $MODDIR/base.apk $YTPATH/base.apk;
fi;