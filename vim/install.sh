sudo apt-get update
sudo apt-get install vim-gtk
sudo apt-get install silversearcher-ag
sudo apt-get install exuberant-ctags
sudo apt-get -y install python-pip
pip install websocket-client sexpdata
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/dodie/vim-monokai-refined.git ~/.vim/bundle/vim-monokai-refined
vim +PluginInstall +qall

