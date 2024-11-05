info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}


install_dependencies () {
  info 'install dependencies'
  yum install xclip
}

install_nvim () {
  info 'install nvim'
  curl -L https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz -o ~/Downloads/nvim-linux64.tar.gz
  tar -xvzf ~/Downloads/nvim-linux64.tar.gz -C ~/Programs/
  ln -s ~/Programs/nvim-linux64/bin/nvim ~/bin/nvim

  # In case stuff is not working, do an update of plugins:
  # Run the `Lazy sync` command in nvim then delete the caches:
  # rm -rf .local/share/nvim
  # rm -rf .cache/nvim
}

install_nerd_fonts () {
  info 'install JetBrainsMonoNL Nerd Font'

  curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip \
    -o ~/Downloads/JetBrainsMono-2.304.zip && \
    unzip ~/Downloads/JetBrainsMono-2.304.zip -d ~/Downloads/JetBrainsMono-2.304 && \
    rm ~/Downloads/JetBrainsMono-2.304.zip

  mkdir -p ~/.local/share/fonts/jetbrains-mono
  find ~/Downloads/JetBrainsMono-2.304 -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} ~/.local/share/fonts/jetbrains-mono \;
  fc-cache -f -v
  rm -rf ~/Downloads/JetBrainsMono-2.304
  success 'JetBrainsMonoNL Nerd Font installed, please set it up in the terminal'
}

install_dependencies
install_nvim
install_nerd_fonts

success 'nvim installed'
