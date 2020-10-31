#!/system/bin/sh

## Mount YouTube Vanced over stock YouTube.
## ipdev @ xda-developers

# Module Directory
MDIR=${0%/*}
# Magisk Modules Directory
MMDIR=${MDIR%/*}
# ADB Directory
ADB=${MMDIR%/*}


# Check and remove extra Vanced files.

if [ -f $ADB/service.d/vanced.sh ]; then
	rm $ADB/service.d/vanced.sh;
fi;

if [ -d $ADB/Vanced ]; then
	rm -rf $ADB/Vanced;
fi;
