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

git config --global core.excludesFile '$HOME/dotfiles/.gitignore.global'

# WSL config
if egrep -qi "Microsoft|WSL" /proc/version; then
  dbus-launch --exit-with-x11 > /dev/null
fi;
. `which env_parallel.bash`

