#Adiciona o repositorio do clang musl pelo git com os patches
echo '
[clang-musl]
sync-uri = https://github.com/clang-musl-overlay/clang-musl-overlay.git
sync-type = git
location = /var/db/repos/clang-musl
sync-depth = 1
' > /etc/portage/repos.conf/clang-musl.conf
git clone https://github.com/clang-musl-overlay/gentoo-patchset /etc/portage/patches/

#Sincroniza o novo repo
emerge --sync --quiet

#Define o perfil como musl-clang
eselect profile set --force 36

#Limpa dependencias como gcc que não são mais nescessarias 
emerge -c 

#Define o llvm para a versão 15 e atualiza e recompila o sistema inteiro 
llvm-conf --enable-native-links --enable-clang-wrappers --enable-binutils-wrappers llvm-15
emerge -euDN @world 
emerge -c 
