#Configura GNOME para funcionar no openrc pelo elogind
rc-update add elogind boot
rc-service elogind start
echo 'DISPLAYMANAGER="gdm"' >> /etc/conf.d/display-manager
rc-update add display-manager default

#Configuracao necessaria para senhas fracas
echo "min=disabled,2,2,2,2
max=40
passphrase=0
match=0
similar=permit
random=0
enforce=none
retry=3" > /etc/security/passwdqc.conf

#Configurando o sudo 
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  

#adiciona usuario
useradd -m gsuzeda
usermod -G wheel,video,plugdev,portage,kvm gsuzeda
passwd gsuzeda
reboot

