export PATH="$HOME/bin:$PATH"

source $HOME/dotfiles/.path
source $HOME/dotfiles/.exports
source $HOME/dotfiles/.bash_prompt
source $HOME/dotfiles/.aliases
source $HOME/dotfiles/.functions

shopt -s nocaseglob;
shopt -s histappend;
shopt -s cdspell;

if [ -f "/etc/bash_completion" ]; then
  source /etc/bash_completion;
fi;

source /usr/share/bash-completion/completions/git
__git_complete g __git_main

if [ ! -f "$HOME/.bashrc" ]; then
  ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
fi;

if [ ! -f "$HOME/.vimrc" ]; then
  ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
fi;

if [ ! -f "$HOME/.tmux.conf" ]; then
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi;

git config --global core.excludesFile '$HOME/dotfiles/.gitignore.global'
