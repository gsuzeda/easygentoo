# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
 export PATH=~/Android/flutter/bin:$PATH
 export PATH=~/Android/Sdk/platform-tools:$PATH
 export PATH=~/Android/Sdk/cmdline-tools/latest/bin:$PATH
 export PATH="/usr/lib/ccache/bin${PATH:+:}${PATH}"
 export PATH=/usr/lib64:$PATH
 export CCACHE_DIR="/var/cache/ccache"
 export CHROME_EXECUTABLE=google-chrome-stable
 
 alias update="sudo emerge --sync && sudo emerge -uDN @world && sudo emerge --depclean; sudo eclean-pkg; sudo eclean --deep distfiles; sudo dispatch-conf; sudo ccache -C; sudo etc-update"
 alias grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
 alias twrp="unset JAVAC; cd ~/Android/twrp; export ALLOW_MISSING_DEPENDENCIES=true;export LC_ALL=C; . build/envsetup.sh; lunch twrp_cannong-eng; mka clean; mka recoveryimage"
 alias recovery="cd out/target/product/cannong/; fastboot flash recovery recovery.img; fastboot reboot recovery"
 alias ofox="unset JAVAC; cd ~/Android/fox_11.0; . build/envsetup.sh; lunch twrp_cannong-eng; mka clean; mka recoveryimage"
 alias potato="unset JAVAC; cd ~/Android/potato;source build/envsetup.sh; lunch potato_cannon-userdebug; mka clean; brunch cannon;"
 alias makeconf="sudo nano /etc/portage/make.conf"
 alias logs="cd ~/Android/logs; adb logcat -d > logcat.txt; adb shell dmesg > dmesg.txt; adb pull /tmp/recovery.log"
