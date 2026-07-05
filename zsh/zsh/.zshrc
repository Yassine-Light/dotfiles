# ===========================================
#  History
# ==========================================

HISTFILE="XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS


# ===============================
#  Shell behaviour
# ===============================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# ===============================
#  Zoxide
# ===============================

eval "$(zoxide init zsh)"


# ===============================
#  Completion
# ===============================

autoload -Uz compinit

compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select

# Completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# ===============================
#  Fuzzy finder
# ===============================

if [[ -f /usr/share/fzf/key-bindings.zsh ]];then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
fi


# ===============================
#  Yazi
# ===============================
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}


# ===============================
#  Config files
# ===============================

# fzf config 
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Keybinds
source "$ZDOTDIR/bindings.zsh"

# Plugins
source "$ZDOTDIR/plugins.zsh"

# Propmt
source "$ZDOTDIR/prompt.zsh"


