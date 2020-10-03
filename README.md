## Inject YouTube Vanced

**Magisk Module**  
_Simple module that uses mount to replace installed regular YouTube with the Vanced version._

### Description
This module will overlay the Vanced apk file over the regular YouTube apk file.  
Requires regular Google YouTube to be installed as a _user_ app. Both versions need to match.  

### Download
Available in the releases tab. [Link](https://github.com/ipdev99/mModule_iYTv/releases)

### How to use
- Install regular YouTube.
- Copy the module zip file to the device.
- Open Magisk Manager, select Modules and then Install from storage.
- Select the zip file and install.
- Reboot device.

### About
This module is based on the new root install method by the Vanced team.  
See xda-developers post [Link](https://forum.xda-developers.com/showpost.php?p=83318971&postcount=16371) for information.  

### To Do
- Write up more detailed Instructions.

### Recent changes
- Some minor cleanup.
- Update to Vanced v15.38.35

---

### Requirements to build
- Linux or MacOS with build (command line) tools installed.  
_aapt cut grep sed zip_  

### How to build
**If you have git installed**
- Run _git clone https://github.com/ipdev99/mModule_iYTv.git_
- Run _mkiytv.sh_ to build
- Zip file(s) will be in the out directory

### Notes
- Feel free to use, change, improve, adapt.
- Remember to share.

### Credits
- The Android Community and everyone who has helped me learn through the years.
- Team Vanced for [_YouTube Vanced Edition_](https://forum.xda-developers.com/android/apps-games/app-youtube-vanced-edition-t3758757) and the new root install method.
- John Wu (@topjohnwu) for all things Magisk.
