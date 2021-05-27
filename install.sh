# set machine id
if [ ! -s "/etc/machine-id" ]; then
  dbus-uuidgen > /etc/machine-id
fi;

# install dependencies
sudo apt install parallel -y
sudo apt install git -y
sudo apt install tmux -y
sudo apt install guake -y

# required for coc-nvim
sudo apt install node -y

# install vim plugins
rm "$HOME/.vimrc"
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc

sudo git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sudo vim +PluginInstall +qall

# install tmux plugins
rm "$HOME/.tmux.conf"
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# set up guake
guake --restore-preferences ~/dotfiles/.guake
source $HOME/.bashrc

