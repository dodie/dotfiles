sudo apt-get install zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# The setup script issues chsh to change the default shell to ZSH. This may fail if your user is managed via LDAP.
# To change the shell in such cases, do the following:
# sudo vi /etc/sssd/sssd.conf
# Add the following line to the [domain/default] section:
# override_shell = /usr/bin/zsh
# Reboot

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git clone https://github.com/ggreer/the_silver_searcher.git ~/.the_silver_searcher
(
cd .the_silver_searcher
./build.sh
make install
)

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install
