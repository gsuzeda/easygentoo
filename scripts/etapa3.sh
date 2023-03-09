#Instala pacotes que EU uso
echo "Essa é a parte mais chata, você deverá resoler os problemas de dependência"
echo "Você deverá em ordem:"
echo "Tentar usar o etc-update"
echo "Tentar reduzir a flag do clang para -03 ou -O2 com flto=thin"
echo "E se o erro continuar, adicionar o pacote dentro do env para compilação via gcc"
emerge gnome-light gdm gnome-terminal gnome-text-editor \
gnome-browser-connector gnome-calculator  sudo sys-fs/fuse \
telegram-desktop-bin gnome-tweaks jdk repo zip python:2.7 \
gnome-system-monitor ncurses-compat intel-undervolt \
libva-intel-media-driver sys-fs/ntfs3g unrar vulkan-loader \
gui-libs/display-manager-init app-arch/unp
