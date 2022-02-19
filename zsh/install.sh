sudo apt-get install zsh
#sudo yum -y install zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# If this command fails because of the following error:
# chsh: user "<user>" does not exist
# Then it might be because your user is managed by LDAP, and have no local entry in /etc/passwd
# To solve it:
#
# sudo vim /etc/sssd/sssd.conf
# 
# And add this line: override_shell = /usr/bin/zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
