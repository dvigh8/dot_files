# Modular zsh configuration
ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source "$ZDOTDIR/shell"
source "$ZDOTDIR/envs"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"
source "$ZDOTDIR/plugins"
source "$ZDOTDIR/op-secrets"
source "$ZDOTDIR/init"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/josephsd/.lmstudio/bin"
# End of LM Studio CLI section

