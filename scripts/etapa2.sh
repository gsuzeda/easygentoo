#Continua processo de chrooting
source /etc/profile
export PS1="(gentoo) ${PS1}"
#Atualiza as fontes e define um perfil 
emerge-webrsync
emerge --sync --quiet
eselect profile set 7
#Configuracoes locais para PT BR
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo "UTC" > /etc/conf.d/hwclock
echo "en_US ISO-8859-1
en_US.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8
"  >> /etc/locale.gen
emerge dejavu
eselect fontconfig enable $(seq 41)
locale-gen
#Instala o grub
emerge grub
mkdir /boot/efi
mount /boot/efi
grub-install --efi-directory=/boot/efi
#Instala e configura programas para viabilizar primeiro boot sem dor de cabeca
mkdir /var/cache/ccache/
emerge ccache
echo 'max_size = 30.0G
umask = 002
cache_dir_levels = 3
compiler_check = %compiler% -v
compression = true
compression_level = 1 ' > /var/cache/ccache/ccache.conf
mkdir -p /etc/portage/repos.conf
emerge eselect-repository networkmanager xwayland linux-firmware mold dev-vcs/git
#Ativa alguns repositorios
eselect repository enable mv lto-overlay ppfeufer-gentoo-overlay src_prepare-overlay brave-overlay
#Instala o Kernel
emerge sys-kernel/xanmod-kernel
#Configura o grub 
grub-mkconfig -o /boot/grub/grub.cfg
eselect kernel set 1
#Configura o repo Portage pelo git
echo "[DEFAULT]
main-repo = gentoo
[gentoo]
location = /usr/portage
sync-type = git
sync-uri = https://github.com/gentoo/gentoo.git
#sync-uri = https://github.com/gentoo-mirror/gentoo.git 
#sync-uri = https://gitweb.gentoo.org/repo/sync/gentoo.git 
auto-sync = yes
 
#[DEFAULT]
#main-repo = gentoo
#
#[gentoo]
#location = /usr/portage
#sync-type = rsync
#sync-uri = rsync://rsync.gentoo.org/gentoo-portage
#auto-sync = yes
 
# for daily squashfs snapshots
#sync-type = squashdelta
#sync-uri = mirror://gentoo/../snapshots/squashfs" >  /etc/portage/repos.conf/gentoo.conf
mkdir /usr/portage-rsync
mv /usr/portage/* /usr/portage-rsync
emerge --sync
mv /usr/portage-rsync/{distfiles,packages} /usr/portage/
rm -rf /usr/portage-rsync
emerge --sync 
eselect news read
# Habilita gerenciador de redes e configura seha
sytemctl enable NetworkManaget
echo "min=disabled,2,2,2,2
max=40
passphrase=0
match=0
similar=permit
random=0
enforce=none
retry=3" > /etc/security/passwdqc.conf 
passwd 
exit

