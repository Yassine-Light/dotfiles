# ~/.config/zsh/.zshenv


# ------------ XDG base directories ------------
# config & cache & data
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ------------ Editor -------------
# Default editor for git
export EDITOR="nvim"
export VISUAL="nvim"

# ------------ RTFM ---------------
export MANROFFOPT="-c"

if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

# ------------ Starship -----------
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# ------------ Path ---------------
export PATH="$HOME/.local/bin:$PATH"
