# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Export correct default shell
export SHELL=/bin/zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="choozn"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="archcraft"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Pywal init
(cat ~/.cache/wal/sequences &)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

autoload -Uz compinit
compinit -C

plugins=(
    git
    sudo
    ssh-agent
    safe-paste
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-vi-mode
    zsh-autocomplete
    zsh-nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# On-demand rehash
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd

# Git binds
alias git-root='git rev-list --max-parents=0 HEAD'
alias add-lines='git add -e'
alias hunk='git add -p'
alias reset-origin='git reset --hard @{u}'
fixup() {
  if [[ "$1" == "root" ]]; then
    git commit --fixup $(git-root)
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    git commit --fixup "HEAD~$1"
  else
    git commit --fixup $1
  fi
}
rebase() {
  if [[ "$1" == "root" ]]; then
    git rebase --autosquash -i --root
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    git rebase --autosquash -i "HEAD~$1"
  else
    git rebase --autosquash -i "$1"
  fi
}
absorb() {
  if [[ "$1" == "root" || -z "$1" ]]; then
    git absorb
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    git absorb --base "HEAD~$1"
  else
    git absorb --base "$1"
  fi
}

# Config binds
alias upgrade='$HOME/.config/hypr/scripts/upgrade'
alias update='$HOME/.config/hypr/scripts/upgrade'

# Other binds
alias zen='zen-browser'
alias open='xdg-open'
alias rgf='rg --files | rg'
alias t='hyprctl dispatch exec "alacritty --working-directory $(pwd)" && clear'
alias n='nix-shell'
cdf() {
  local file
  if [ "$PWD" = "$HOME" ]; then
    file=$(rg --files --hidden --no-ignore ~ 2>/dev/null | fzf)
  else
    file=$(
      {
        rg --files --hidden --no-ignore . 2>/dev/null
        rg --files --hidden --no-ignore ~ 2>/dev/null
      } | awk -v pwd="$PWD/" '$0 !~ "^"pwd { print }' | fzf
    )
  fi
  [ -n "$file" ] && cd "$(dirname "$file")"
}

# ZVM configuration
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZVM_CURSOR_STYLE_ENABLED=true
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
ZVM_KEYTIMEOUT=0.2
ZVM_VI_EDITOR=$EDITOR
zvm_after_init_commands+=(
    "bindkey '^[[A' up-line-or-search"
    "bindkey '^[[B' down-line-or-search"
    "bindkey '^I'   autosuggest-accept"

    # For zsh-autocomplete menu navigation in vi mode
    "bindkey -M viins      '^J' down-line-or-search"
    "bindkey -M viins      '^K' up-line-or-search"
    "bindkey -M vicmd      'j'  down-line-or-search"
    "bindkey -M vicmd      'j'  menu-select"
    "bindkey -M vicmd      'k'  up-line-or-search"
    "bindkey -M menuselect 'j'  down-line-or-search"
    "bindkey -M menuselect 'k'  up-line-or-search"

    # Tab behavior
    "bindkey               '^I' menu-complete"
    "bindkey               '^I' menu-select"
    "bindkey -M menuselect '^I' down-line-or-search"

    # Autosuggestions
    "bindkey '^E' autosuggest-accept"
    "bindkey '^[[C' autosuggest-accept"

    # Allow arrow key movement in menu
    "bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char"
    "bindkey -M menuselect  '^[[C' .forward-char   '^[OC' .forward-char"

    # Autocomplete configuration
    "zstyle ':completion:*:cd:*' tag-order  '! (|*-)directories' -"
    "zstyle ':autocomplete:*complete*:*' insert-unambiguous yes"
    "zstyle ':autocomplete:*history*:*' insert-unambiguous yes"
    "zstyle ':autocomplete:menu-search:*' insert-unambiguous yes"
    "zstyle ':autocomplete:*' add-space '*'"
    "zstyle ':autocomplete:*' remove-semicolon no"
    "zstyle ':autocomplete:*' delay 0.1"
)

# Initialize zoxide
eval "$(zoxide init zsh --cmd cd)"

