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

source $(brew --prefix)/etc/bash_completion
__git_complete g __git_main

git config --global core.excludesFile '$HOME/dotfiles/.gitignore.global'

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

