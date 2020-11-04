#!/system/bin/sh

## This module includes a boot script and the Vanced base.apk file.
## For compatibility reasons, the Vanced boot scripts and base.apk file are removed.
## ipdev @ xda-developers

# Module Directory
MDIR=${0%/*}
# Magisk Modules Directory
MMDIR=${MDIR%/*}
# ADB Directory
ADB=${MMDIR%/*}

# Check and remove extra Vanced files.
if [ -f $ADB/post-fs-data.d/vanced.sh ]; then
	rm $ADB/post-fs-data.d/vanced.sh;
fi;

if [ -f $ADB/service.d/vanced.sh ]; then
	rm $ADB/service.d/vanced.sh;
fi;

if [ -d $ADB/Vanced ]; then
	rm -rf $ADB/Vanced;
fi;
