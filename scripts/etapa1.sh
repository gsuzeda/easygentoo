#Cria e monta o HD no mnt
mkdir /mnt/gentoo
mount /dev/nvme0n1p2 /mnt/gentoo
chmod 777 /mnt/gentoo
rm ../../easygentoo*.zip
cp -r ../../easygentoo* /mnt/gentoo
cd /mnt/gentoo

#Baixa e extrai o stage3
wget https://gentoo.c3sl.ufpr.br/releases/amd64/autobuilds/latest-stage3-amd64-musl-llvm.txt
grep stage3 latest-stage3-amd64-musl-llvm.txt | rev | cut -c 11- | rev > latest.txt 
wget https://gentoo.c3sl.ufpr.br/releases/amd64/autobuilds/$(cat latest.txt)
tar xpvf stage3* --xattrs-include='*.*' --numeric-owner
rm -f *latest* stage3*

#Chrooting e importação de configuracoes
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run 
cp /etc/resolv.conf /mnt/gentoo/etc/
cp -r /mnt/gentoo/easygentoo-main/files/* /mnt/gentoo/
chroot /mnt/gentoo /bin/bash
