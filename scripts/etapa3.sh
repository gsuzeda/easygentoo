#Atualiza a porra toda e instala o ltoize
emerge -uDN @world
#Instala pacotes problematicos com o lto
emerge opus gst-plugins-good pipewire
#Configura o ltoize e o gnome 
emerge ltoize
echo "#lto" >> /etc/portage/make.conf
echo "source /etc/portage/make.conf.lto" >> /etc/portage/make.conf 
echo "gnome-base/gnome -extras" > /etc/portage/package.use/gnome
#Aplica o ltoize
emerge -e @world --keep-going
emerge --depclean
#Instala pacotes que EU uso
emerge gnome-light gdm gnome-terminal google-chrome gedit gnome-calculator github-desktop vscode sudo telegram-desktop-bin whatsapp-desktop-bin gnome-tweaks f2fs-tools jdk unp repo zip python:2.7 gnome-system-monitor ncurses-compat intel-undervolt libva-intel-media-driver
systemctl enable gdm bluetooth 
#Configuracao necessaria para senhas fracas
echo "min=disabled,2,2,2,2
max=40
passphrase=0
match=0
similar=permit
random=0
enforce=none
retry=3" > /etc/security/passwdqc.conf
#configura undervolt 
echo "enable no
undervolt 0 'CPU' -90
undervolt 1 'GPU' -40
undervolt 2 'CPU Cache' -90
undervolt 3 'System Agent' -40
undervolt 4 'Analog I/O' -40
interval 5000
daemon undervolt:once
daemon power
daemon tjoffset
" > /etc/intel-undervolt.conf
systemctl enable intel-undervolt
#Configurando o sudo 
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  
#adiciona usuario
useradd -m gsuzeda
usermod -G wheel,audio,video,plugdev,portage,kvm gsuzeda
passwd gsuzeda
reboot

