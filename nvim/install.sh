yum install xclip
curl -L https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz -o ~/Downloads/nvim-linux64.tar.gz
tar -xvzf ~/Downloads/nvim-linux64.tar.gz -C ~/Programs/
ln -s ~/Programs/nvim-linux64/bin/nvim ~/bin/nvim

# In case stuff is not working, do an update of plugins:
# Run the `Lazy sync` command in nvim then delete the caches:
# rm -rf .local/share/nvim
# rm -rf .cache/nvim
