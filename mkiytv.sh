#!/bin/bash

## Inject YouTube Vanced
## ipdev @ xda-developers

# Set main variables
DATE=$(date '+%Y%m%d')
TDIR=$(pwd)
SDIR="$TDIR"/staging
OUT="$TDIR"/out/"$DATE"

# Set additional variables
NAME=iYTv
IYTVB=NONE
IYTVD=NONE
BUZB=NONE
BUZD=NONE

# Set main functions

check_dir() {
	if [ ! -d "$TDIR"/staging ]; then
	mkdir "$TDIR"/staging
	fi;

	if [ ! -d "$TDIR"/out ]; then
	mkdir "$TDIR"/out
	fi;

	if [ ! -d "$TDIR"/out/"$DATE" ]; then
	mkdir "$TDIR"/out/"$DATE"
	fi;
}

# Set additional functions

backup() {
	if [ -f "$OUT"/"$ZIPNAME" ]; then
		FLTM=$(date -r "$OUT"/"$ZIPNAME" '+%H%M');
		BACKUPFILE=$(printf "$ZIPNAME" | sed 's/.zip/-'"$FLTM".zip'/g');
		mv "$OUT"/"$ZIPNAME" "$OUT"/"$BACKUPFILE";
		if [ $MODID = b ]; then
			BUZB=""$OUT"/"$BACKUPFILE"";
		fi;

		if [ $MODID = d ]; then
			BUZD=""$OUT"/"$BACKUPFILE"";
		fi;
	fi;
}

edit_service_script() {
	if [ "$(uname -s)" = Darwin ]; then
		RNAME=$(grep "Required YouTube" service.sh | cut -f6 -d' ');
		sed -i "" s/$RNAME/$VNAME/ service.sh;
		RCODE=$(grep "RVCODE=" service.sh);
		sed -i "" s/$RCODE/RVCODE=$VCODE/ service.sh;
	else
		RNAME=$(grep "Required YouTube" service.sh | cut -f6 -d' ');
		sed -i s/$RNAME/$VNAME/ service.sh;
		RCODE=$(grep "RVCODE=" service.sh);
		sed -i s/$RCODE/RVCODE=$VCODE/ service.sh;
	fi;
}

get_app_version() {
	VCODE=$(aapt dump badging base.apk| grep version | cut -f4 -d"'");
	VNAME=$(aapt dump badging base.apk| grep version | cut -f6 -d"'");
	VER=$(aapt dump badging base.apk| grep version | cut -f6 -d"'" | sed 's/\.//g');
}

module_prop() {
	echo "id=iytv"$MODID"" >>module.prop
	echo "name=iYTvanced "$THEME"" >>module.prop
	echo "version=Module" >>module.prop
	echo "versionCode="$VCODE"" >>module.prop
	echo "author=ip" >>module.prop
	echo "description=Vanced YouTube v"$VNAME" "$THEME" Theme" >>module.prop
}

# Check and create directory(s) if needed.
check_dir

# Make zip file(s).

if [ -f black.apk ]; then
	echo ""; echo "iYTv Black";
	MODID=b
	THEME="Black"
	cp -rf META-INF "$SDIR"
	cp customize.sh "$SDIR"
	cp post-fs-data.sh "$SDIR"
	cp service.sh "$SDIR"
	cp black.apk "$SDIR"/base.apk
	cd "$SDIR"
	get_app_version
	module_prop
	edit_service_script
	ZIPNAME="$NAME"-"$THEME"-v"$VER".zip
	IYTVB=""$OUT"/"$ZIPNAME""
	zip -r "$ZIPNAME" META-INF/* base.apk customize.sh module.prop post-fs-data.sh service.sh
	backup
	mv "$ZIPNAME" "$OUT"
	rm -rf *
	cd "$TDIR"
fi;

if [ -f dark.apk ]; then
	echo ""; echo "iYTv Dark";
	MODID=d
	THEME="Dark"
	cp -rf META-INF "$SDIR"
	cp customize.sh "$SDIR"
	cp post-fs-data.sh "$SDIR"
	cp service.sh "$SDIR"
	cp dark.apk "$SDIR"/base.apk
	cd "$SDIR"
	get_app_version
	module_prop
	edit_service_script
	ZIPNAME="$NAME"-"$THEME"-v"$VER".zip
	IYTVD=""$OUT"/"$ZIPNAME""
	zip -r "$ZIPNAME" META-INF/* base.apk customize.sh module.prop post-fs-data.sh service.sh
	backup
	mv "$ZIPNAME" "$OUT"
	rm -rf *
	cd "$TDIR"
fi;

if [ ! -f black.apk ] | [ ! -f dark.apk ]; then
	echo ""; echo "Nothing to do.";
fi;

# Note backup file(s).
if [ -f $BUZB ] || [ -f $BUZD ]; then
	echo ""; echo "Your previous zip file(s) renamed.";
fi;

if [ -f $BUZB ]; then
	echo " iYTv Black backup as "$BUZB"";
fi;

if [ -f $BUZD ]; then
	echo " iYTv Dark backup as "$BUZD"";
fi;

# Note new file(s).
if [ -f $IYTVB ] || [ -f $IYTVD ]; then
	echo ""; echo "New zip file(s).";
fi;

if [ -f $IYTVB ]; then
	echo " iYTv Black saved as "$IYTVB"";
fi;

if [ -f $IYTVD ]; then
	echo " iYTv Dark saved as "$IYTVD"";
fi;

# Finish script.
echo ""; echo "Done."; echo "";
exit 0;
