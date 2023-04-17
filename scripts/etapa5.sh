sudo emerge --sync --quiet 
sudo emerge --update --newuse --deep --with-bdeps=y @world
sudo emerge -c
eselect news read
sudo etc-update

#Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo '
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
' >>  ~/.zshrc

