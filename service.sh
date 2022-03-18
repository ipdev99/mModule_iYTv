#!/system/bin/sh

## Mount YouTube Vanced over stock YouTube.
## ipdev @ xda-developers

## Requires YouTube to be installed as a user app.
## Required YouTube version is 16.29.39

# Module directory set by Magisk.
MODDIR=${0%/*}

# Run mount.
RUNMOUNT=TRUE

# Required YT versionCode.
RVCODE=1522269632

# Get SDK level and architecture.
SDK=$(getprop ro.build.version.sdk);
# ARCH=$(getprop ro.product.cpu.abi);

# Find and set YouTube path.
if [ $SDK -ge 30 ]; then
	YTPATH=$(readlink -f /data/app/*/com.google.android.youtube*/lib | sed 's/\/lib//g');
else
	YTPATH=$(readlink -f /data/app/com.google.android.youtube*/lib | sed 's/\/lib//g');
fi;

# Check YouTube path.
if [ ! -f $YTPATH/base.apk ]; then
	echo "$(date '+%Y%m%d_%H%M')" "No user installed YouTube path found." >>$MODDIR/error.log;
	RUNMOUNT=ABORT;
fi;

# Find installed (active) YouTube versionCode.
if [ $RUNMOUNT = TRUE ]; then
	while [ -z $YTVCODE ]; do
		YTVCODE=$(dumpsys package com.google.android.youtube | grep versionCode | cut -f2 -d'=' | tr -d '\n' | cut -f1 -d' ');
		sleep 1;
	done;
fi;

# Check YouTube versionCode.
if [ ! $YTVCODE = $RVCODE ]; then
	echo "$(date '+%Y%m%d_%H%M')" "Wrong version of YouTube found." >>$MODDIR/error.log;
	RUNMOUNT=ABORT;
elif [ -z $YTVCODE ]; then
	echo "$(date '+%Y%m%d_%H%M')" "No user installed version of YouTube found." >>$MODDIR/error.log;
	RUNMOUNT=ABORT;
fi;

# Mount Vanced if failsafe(s) pass.
if [ $RUNMOUNT = TRUE ]; then
	su -c mount -o bind $MODDIR/base.apk $YTPATH/base.apk;
fi;
