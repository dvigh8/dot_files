# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"
 
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000       # in‑memory lines
SAVEHIST=200000       # saved to file

setopt APPEND_HISTORY           # append (not overwrite)
setopt INC_APPEND_HISTORY       # write commands as they are entered
setopt SHARE_HISTORY            # share history across sessions
setopt HIST_EXPIRE_DUPS_FIRST   # when trimming, drop older dups
setopt HIST_IGNORE_DUPS         # ignore duplicate adjacent entries
setopt HIST_IGNORE_ALL_DUPS     # remove older duplicates
setopt HIST_REDUCE_BLANKS       # trim superfluous spaces
setopt EXTENDED_HISTORY         # save timestamps with history entries
# Would you like to use another custom folder than $ZSH/custom?

# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git web-search vi-mode)

ZSH_WEB_SEARCH_ENGINES=(
    kagi "https://kagi.com/search?q="
    k "https://kagi.com/search?q="
    ask "https://kagi.com/assistant?q="
    a "https://kagi.com/assistant?q="
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias workflow="gcloud dataproc workflow-templates"

alias lz="lazygit"
alias g="lazygit"
autoload -U compinit
compinit -i

if [[ $(uname) == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  source <(fzf --zsh)
else

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
  [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  export PATH=/opt/homebrew/bin:$PATH
fi
eval "$(zoxide init zsh)"
alias te='cd "$(lf -print-last-dir "$@")"'
# Only set the alias if not in Claude CLI context
alias ls='eza'

function lst(){
  #ls --tree --level=3 -l --git 
  if [ "$1" != "" ]
  then
    ls -l --tree --level="$1" --git
  else
    ls -l --git
  fi
}
alias cluster="$HOME/venv/bin/python -m cluster_manager"
alias vi="nvim"
alias db="databricks"
bindkey '^R' fzf-history-widget
bindkey '^E'  fzf-cd-widget
PATH="$PATH":"/Applications/CMake.app/Contents/bin:$HOME/.cargo/bin"
export XDG_CONFIG_HOME=$HOME/.config/
alias dbb="databricks bundle"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias dot='GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME lazygit'

alias dotall='GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME GIT_CONFIG_PARAMETERS="'\''status.showUntrackedFiles=normal'\''" lazygit'
. $HOME/.envs

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/djosephs@amgen.com/Downloads/google-cloud-sdk 2/path.zsh.inc' ]; then . '/Users/djosephs@amgen.com/Downloads/google-cloud-sdk 2/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/djosephs@amgen.com/Downloads/google-cloud-sdk 2/completion.zsh.inc' ]; then . '/Users/djosephs@amgen.com/Downloads/google-cloud-sdk 2/completion.zsh.inc'; fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/josephsd/.lmstudio/bin"
# End of LM Studio CLI section

# source ~/powerlevel10k/powerlevel10k.zsh-theme
autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

. "$HOME/.local/bin/env"

complete -o nospace -C /opt/homebrew/bin/terraform terraform
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

find_and_activate_venv() {
    local current_dir="$PWD"
    local venv_dirs=(".venv" "venv" ".virtualenv" "virtualenv")

    while [[ "$current_dir" != "/" ]]; do
        for venv_name in "${venv_dirs[@]}"; do
            if [[ -d "$current_dir/$venv_name" ]] && [[ -f "$current_dir/$venv_name/bin/activate" ]]; then
                echo "🐍 Activating venv: $current_dir/$venv_name"
                source "$current_dir/$venv_name/bin/activate"
                return 0
            fi
        done
        current_dir="$(dirname "$current_dir")"
    done

    echo "❌ No virtual environment found in parent directories"
    return 1
}

# Deactivate current venv if any, then activate the found one
auto_venv() {
    [[ -n "$VIRTUAL_ENV" ]] && deactivate
    find_and_activate_venv
}

alias venv='auto_venv'
c_heic(){
    for f in *.heic; do
        magick "$f" -define jpeg:extent=5MB "${f%.heic}.jpg"
    done
}
alias heic='magick mogrify -format jpg $(pwd)/*.heic'
data_dir() {
  local start="${1:-$PWD}"
  
  # Step 0: if DATA_DIR env var is set, prefer it
  if [[ -n "$DATA_DIR" ]]; then
    local target="${DATA_DIR:A}"  # resolve to absolute path
    if [[ ! -d "$target" ]]; then
      mkdir -p "$target" || { echo "Error: Failed to create $target" >&2; return 1; }
      echo "Created data directory at $target" >&2
    fi
    echo "$target"
    return 0
  fi 

  local dir="${start:A}"   # absolute path (resolves symlinks)

  # Step 1 & 2: walk upward for nearest data/
  while true; do
    if [[ -d "$dir/data" ]]; then
      echo "$dir/data"
      return 0
    fi
    local parent="${dir:h}"
    if [[ "$parent" == "$dir" ]]; then
      break  # reached filesystem root
    fi
    dir="$parent"
  done

  # Step 3: must be inside a git repo, else fail
  local git_root
  git_root=$(git -C "$start" rev-parse --show-toplevel 2>/dev/null) || {
    echo "Error: Not inside a Git repository. No data/ directory created." >&2
    return 1
  }

  local git_parent="${git_root:h}"
  local repo_name="${git_root:t}"
  local target="$git_parent/data/$repo_name"

  if [[ ! -d "$target" ]]; then
    mkdir -p "$target" || { echo "Error: Failed to create $target" >&2; return 1; }
    echo "Created data directory at $target" >&2
  fi

  echo "$target"
}
alias dd='data_dir'
alias cdd='cd "$(data_dir)"'
mvtdd() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: mvtdd <file-or-folder> [more files...]"
    return 1
  fi

  local target
  target=$(data_dir) || return 1

  # Use -i so mv asks before overwriting existing files
  mv -i "$@" "$target"/
  echo "Moved $@ → $target/"
}
lsdd() {
  local target
  target=$(data_dir) || return 1
  echo "Data directory: $target"

  # If no extra args, just list the root data_dir
  if [[ $# -eq 0 ]]; then
    ls -la "$target"
  else
    for sub in "$@"; do
      if [[ -d "$target/$sub" || -f "$target/$sub" ]]; then
        echo "--- $target/$sub ---"
        ls -la "$target/$sub"
      else
        echo "Warning: $target/$sub does not exist" >&2
      fi
    done
  fi
}
alias ydd='yazi $(data_dir)'
[ -f "$HOME/.commands_manager" ] && source "$HOME/.commands_manager"
alias rzsh='source ~/.zshrc'
alias ezsh='$EDITOR ~/.zshrc' #will open .zshrc for editing from any directory

# quick search in files
ff() { rg -n "$@"; }


