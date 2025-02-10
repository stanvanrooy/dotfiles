#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" == "Darwin" ]]; then
  isMac="true"
else
  isMac="false"
fi

if ! command -v brew &>/dev/null; then
  if [ -x /opt/homebrew/bin/brew ]; then
    echo "Adding /opt/homebrew/bin to PATH..."
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    echo "Adding /usr/local/bin to PATH..."
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Please install Homebrew from https://brew.sh/ and rerun this script."
  exit 1
fi

export HOMEBREW_NO_AUTO_UPDATE=1

[ ! -f "$HOME/.bashrc" ]    && ln -s "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"    || echo ".bashrc exists; skipping."
[ ! -f "$HOME/.vimrc" ]     && ln -s "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"      || echo ".vimrc exists; skipping."
[ ! -f "$HOME/.tmux.conf" ] && ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"  || echo ".tmux.conf exists; skipping."
[ ! -f "$HOME/.gitconfig" ] && ln -s "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"  || echo ".gitconfig exists; skipping."

if [ ! -f "$HOME/.config/nvim/init.vim" ]; then
  mkdir -p "$HOME/.config/nvim"
  ln -s "$HOME/dotfiles/.init.vim" "$HOME/.config/nvim/init.vim"
  echo "Created symlink for nvim init.vim"
else
  echo "nvim init.vim exists; skipping."
fi

if [ "$isMac" == "true" ]; then
  # Install Homebrew if not in PATH (fresh install).
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew update
  brew install git vim tmux kubernetes-cli azure-cli node@20 bash-completion@2 nvim docker docker-compose gh
else
  sudo apt update
  sudo apt install -y curl vim tmux neovim git docker docker-compose python3 dotnet-sdk-7.0
fi

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
fi

if [ "$isMac" == "false" ]; then
  sudo curl -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
  sudo curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker
  sudo curl -L https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -o /etc/bash_completion.d/az
  sudo bash -c 'kubectl completion bash > /etc/bash_completion.d/kubectl'
fi

if [ ! -f "$HOME/.exports_private" ]; then
  echo "Warning: $HOME/.exports_private does not exist; creating an empty file."
  touch "$HOME/.exports_private"
fi

source "$HOME/.bashrc"

echo "Installation complete. You may need to log out and back in for all changes to take effect."

