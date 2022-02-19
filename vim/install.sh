sudo apt-get update
sudo apt-get install vim-gtk
sudo apt-get install exuberant-ctags
#sudo apt-get -y install python-pip
#pip install websocket-client sexpdata

sudo apt-get install silversearcher-ag
# If the above fails, build it from source:
# sudo yum install -y pcre-devel
# sudo yum install xz-devel
# cd temp
# git clone https://github.com/ggreer/the_silver_searcher.git
# cd the_silver_searcher
# ./build.sh
# sudo make install

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/dodie/vim-monokai-refined.git ~/.vim/bundle/vim-monokai-refined
vim +PluginInstall +qall

