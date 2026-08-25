# Login shells don't read ~/.bashrc; source it so dotfiles load.
[[ -r "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
