# Create symlinks if they do not exists
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

if [ ! -f "$HOME/.vimrc" ]; then
  ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
fi

if [ ! -f "$HOME/.config/nvim/init.vim" ]; then
  mkdir -p $HOME/.config/nvim
  ln -s $HOME/dotfiles/.init.vim $HOME/.config/nvim/init.vim
fi

if [ ! -f "$HOME/.tmux.conf" ]; then
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi

if [ ! -d "$HOME/zet" ]; then
  git clone git@github.com:stanvanrooy/zet.git $HOME/zet
fi

# Install dependencies
brew install git
brew install vim
brew install tmux
brew install kubernetes-cli
brew install azure-cli
brew install node@16
brew install bash-completion@2
brew install nvim
brew install docker
brew install docker-compose

# Install vim plugins
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

# Build coc.nvim
cd $HOME/.vim/bundle/coc.nvim/
sudo npm i -g yarn
yarn install
yarn build

# Install tmux plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

source $HOME/dotfiles/.bashrc

