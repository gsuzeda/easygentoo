#Cria e monta o HD no mnt
mkdir /mnt/gentoo
mount /dev/nvme0n1p2 /mnt/gentoo
chmod 777 /mnt/gentoo
rm ../../easygentoo*.zip
cp ../../easygentoo* /mnt/gentoo
cd /mnt/gentoo
#Baixa e instala o stage3
wget https://mirror.ufro.cl/gentoo/releases/amd64/autobuilds/latest-stage3-amd64-desktop-systemd.txt
grep stage3 latest-stage3-amd64-desktop-systemd.txt | rev | cut -c 11- | rev > latest.txt 
wget https://mirror.ufro.cl/gentoo/releases/amd64/autobuilds/$(cat latest.txt)
rm https://mirror.ufro.cl/gentoo/releases/amd64/autobuilds/latest-stage3-amd64-desktop-systemd.txt
tar xpvf stage3* --xattrs-include='*.*' --numeric-owner
rm -f stage3*
#Chrooting e importacao de configuracoes
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run 
cp /etc/resolv.conf /mnt/gentoo/etc/
wget  https://raw.githubusercontent.com/gsuzeda/easygentoo/main/files/fstab?token=GHSAT0AAAAAABRCDFVFY5O35K6DLWA2KQHWYP64BQQ -O /mnt/gentoo/etc/fstab
wget  https://raw.githubusercontent.com/gsuzeda/easygentoo/main/files/make.conf?token=GHSAT0AAAAAABRCDFVEGHF3D6BSR3LZNUPOYP64COA -O /mnt/gentoo/etc/portage/make.conf
chroot /mnt/gentoo /bin/bash
