mkdir -p  $HOME/.config/nvim/
config_file=$HOME/.config/nvim/init.vim
touch $config_file

echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> $config_file
echo "let &packpath=&runtimepath" >> $config_file
echo "source ~/.vimrc" >> $config_file
