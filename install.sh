# set machine id
if [ ! -s "/etc/machine-id" ]; then
  dbus-uuidgen > /etc/machine-id
fi;

# create symlinks if they do not exists
if [ ! -f "$HOME/.bashrc" ]; then
  ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
fi;

if [ ! -f "$HOME/.vimrc" ]; then
  ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
fi;

if [ ! -f "$HOME/.tmux.conf" ]; then
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi;

if [ ! -f "$HOME/.gitconfig" ]; then
  ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi;

if [ ! -f "$HOME/.config/i3/config" ]; then
  ln -s $HOME/dotfiles/i3.conf $HOME/.config/i3/config
fi;

git clone git@github.com:stanvanrooy/zet.git $HOME/zet

# install dependencies
sudo apt install parallel -y
sudo apt install git -y
sudo apt install tmux -y

# required for coc-nvim
sudo apt install vim -y
sudo apt install nodejs -y

# install vim plugins
rm "$HOME/.vimrc"
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc

# install go
sudo tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# install tmux plugins
rm "$HOME/.tmux.conf"
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# install nodejs
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# build coc.nvim
cd $HOME/.vim/bundle/coc.nvim/
sudo npm i -g yarn
yarn install
yarn build

source $HOME/dotfiles/.bashrc

