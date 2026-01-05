# Modular zsh configuration
ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source "$ZDOTDIR/shell"
source "$ZDOTDIR/envs"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"
source "$ZDOTDIR/plugins"
source "$ZDOTDIR/init"
