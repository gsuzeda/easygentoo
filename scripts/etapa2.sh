#Continua processo de chrooting
source /etc/profile
export PS1="(gentoo) ${PS1}"

#Atualiza as fontes e define um perfil 
emerge-webrsync
emerge --sync --quiet
eselect profile set default/linux/amd64/17.1/desktop/gnome/systemd

#Configuracoes locais para PT BR
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo 'clock_hctosys="YES" 
clock_systohc="YES"
# clock="local"
' > /etc/conf.d/hwclock
echo "en_US ISO-8859-1
en_US.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8
"  >> /etc/locale.gen
echo gentoo > /etc/hostname
emerge dejavu
eselect fontconfig enable 33 32 34
locale-gen

#Instala e configura o CCACHE
mkdir /var/cache/ccache/
emerge ccache
echo 'max_size = 100.0G
umask = 002
cache_dir_levels = 3
compiler_check = %compiler% -v
compression = true
compression_level = 1 ' > /var/cache/ccache/ccache.conf

#Adiciona alguns repositórios e instala utilitarios necessários para prosseguir 
mkdir -p /etc/portage/repos.conf
emerge sys-fs/dosfstools sys-boot/grub eselect-repository mold linux-firmware dev-vcs/git 
USE=minimal emerge libsndfile
eselect repository enable src_prepare-overlay cova

#Sincroniza os novos repositórios
emerge --sync --quiet

#Instala o Kernel
emerge sys-kernel/xanmod-kernel
eselect kernel set 1

#Configura o grub 
mount /boot
mkdir /boot/efi
mkfs.fat -F 32 -n efi-boot /dev/nvme0n1p1
mount /boot/efi


grub-install --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg


#Configura a senha de Root
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

