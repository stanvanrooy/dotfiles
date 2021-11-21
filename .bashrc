export PATH="$HOME/bin:$PATH"

source $HOME/dotfiles/.path
source $HOME/dotfiles/.exports
source $HOME/dotfiles/.bash_prompt
source $HOME/dotfiles/.aliases
source $HOME/dotfiles/.functions
source $HOME/dotfiles/.completions

shopt -s nocaseglob;
shopt -s histappend;
shopt -s cdspell;

source $(brew --prefix)/etc/bash_completion

git config --global core.excludesFile '$HOME/dotfiles/.gitignore.global'
__git_complete g __git_main

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

