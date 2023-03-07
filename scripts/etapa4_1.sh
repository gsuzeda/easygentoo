#Configura GNOME para funcionar no openrc pelo elogind
rc-update add elogind boot
rc-service elogind start
echo 'DISPLAYMANAGER="gdm"' >> /etc/conf.d/display-manager
rc-update add display-manager default
rc-service display-manager start

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

#Configurando o sudo 
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  

#adiciona usuario
useradd -m gsuzeda
usermod -G wheel,video,plugdev,portage,kvm gsuzeda
passwd gsuzeda
reboot

