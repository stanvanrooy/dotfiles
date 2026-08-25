export PATH="$HOME/bin:$PATH"

source $HOME/.exports_private
source $HOME/dotfiles/aliases
source $HOME/dotfiles/bash_prompt
source $HOME/dotfiles/completions
source $HOME/dotfiles/exports
source $HOME/dotfiles/functions
source $HOME/dotfiles/path

shopt -s nocaseglob;
shopt -s histappend;
shopt -s cdspell;

if command -v brew &>/dev/null; then
  BREW_BC="$(brew --prefix)/etc/profile.d/bash_completion.sh"
  [[ -r "$BREW_BC" ]] && source "$BREW_BC"
fi

git config --global core.excludesFile '$HOME/dotfiles/.gitignore.global'

#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach -t default || tmux new -s default
#fi
