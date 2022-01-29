#Continua processo de chrooting
source /etc/profile
export PS1="(gentoo) ${PS1}"
mount /dev/nvme0n1p1 /boot
#Atualiza as fontes e define um perfil 
emerge-webrsync
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
eselect locale set 7
#Instala o grub
emerge grub
mkdir /boot/efi
grub-install --efi-directory=/boot/efi
#Instala e configura programas para viabilizar primeiro boot sem dor de cabeca
emerge ccache eselect-repository networkmanager gentoo-kernel linux-firmware mold
mkdir /var/cache/ccache/
echo 'max_size = 50.0G
umask = 002
cache_dir_levels = 3
compiler_check = %compiler% -v
compression = true
compression_level = 1 ' > /var/cache/ccache/ccache.conf 
mkdir -p /etc/portage/repos.conf
#Configura o grub 
grub-mkconfig -o /boot/grub/grub.cfg
#Ativa alguns repositorios atualiza com o sistema e le as noticias
eselect repository enable mv lto-overlay ppfeufer-gentoo-overlay
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

