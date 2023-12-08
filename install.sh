isMac=$(uname -s | grep -q "Darwin" && echo "true" || echo "false")

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

# Install dependencies
if [ "$isMac" == "true" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
else
  sudo apt install -y curl
  # Setup kubectl repo
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

  # Setup nodejs repo
  curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash

  # Setup docker repo
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update
  sudo apt install -y vim neovim tmux kubectl bash-completion nodejs docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin python3 dotnet-sdk-7.0
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

# Install vim plugins
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

# Install tmux plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

# Install completions
sudo curl \
  -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
  -o /etc/bash_completion.d/docker-compose
sudo curl \
  -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker \
  -o /etc/bash_completion.d/docker
sudo curl \
  -L https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion \
  -o /etc/bash_completion.d/az
sudo bash -c 'kubectl completion bash > /etc/bash_completion.d/kubectl'

source $HOME/dotfiles/.bashrc

