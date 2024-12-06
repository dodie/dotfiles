sudo apt-get install zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# The setup script issues chsh to change the default shell to ZSH. This may fail if your user is managed via LDAP.
# To change the shell in such cases, do the following:
# sudo vi /etc/sssd/sssd.conf
# Add the following line to the [domain/default] section:
# override_shell = /usr/bin/zsh
# Reboot

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Provide ag - deprecated, use rg instead - TODO remove this section
# git clone https://github.com/ggreer/the_silver_searcher.git ~/.the_silver_searcher
# (
# yum -y install pcre-devel
# cd .the_silver_searcher
# ./build.sh
# ln -s ~/.the_silver_searcher/ag ~/bin/ag
# )

# Install rg
# TODO: align .zshrc so rg is used
(
cd ~/Programs
curl -L https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz -o ripgrep.tar.gz
tar -xvf ripgrep.tar.gz
rm ripgrep.tar.gz
ln -s ~/Programs/ripgrep-14.1.1-x86_64-unknown-linux-musl/rg ~/bin/rg
)

# Install fd
(
cd ~/Programs
curl -L https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz -o fd.tar.gz
tar -xvf fd.tar.gz
rm fd.tar.gz
ln -s ~/Programs/fd-v10.2.0-x86_64-unknown-linux-gnu/fd ~/bin/fd
)

# Requirements for python
sudo yum -y install sqlite-devel
sudo yum -y install libffi-dev
sudo yum -y install bzip2-devel
sudo yum -y install ncurses-devel

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python
asdf install
