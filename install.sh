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

if [ ! -f "$HOME/.vimrc" ]; then
  ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
fi

if [ ! -f "$HOME/.tmux.conf" ]; then
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi

if [ ! -d "$HOME/zet" ]; then
  git clone git@github.com:stanvanrooy/zet.git $HOME/zet
fi

# install dependencies
sudo apt install parallel -y
sudo apt install git -y
sudo apt install tmux -y

# required for coc-nvim
if [ ! $(which vim) ]; then
  sudo apt install vim -y
fi

if [ ! $(which vim) ]; then
  sudo apt install nodejs -y
fi

# install go
if [ ! $(which go) ]; then
  sudo tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
fi

# install kubectl
if [ ! $(which kubectl) ]; then
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

# install tmux plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

# install nodejs
if [ ! $(which node) ]; then
  curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt install -y nodejs
fi

# build coc.nvim
cd $HOME/.vim/bundle/coc.nvim/
sudo npm i -g yarn
yarn install
yarn build

# install jq
sudo apt install -y jq

source $HOME/dotfiles/.bashrc

