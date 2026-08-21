# ============================
#  LIFE IS GOOD CLI
# ============================

# ls on drugs
alias ls='eza -lh --icons --git'

# ls with sharingan on drugs
alias la='eza -lah --icons --git'

# ls drug tree
alias tree='eza --tree --icons --git'

# same completion
compdef eza=ls

# I'm batman's cat
alias cat='bat'


# ============================
#  COOL STUFF
# ============================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'


# ============================
#  NAV 
# ============================

alias -- -='cd -'


# ============================
#  PACMAN 
# ============================

alias p='sudo pacman'
alias pi='sudo pacman -S'
alias pse='sudo pacman -Ss'
alias pu='sudo pacman -Syu'
alias pfu='sudo pacman -Syyu'
alias pr='sudo pacman -Rns'
alias pinst='sudo pacman -Qe'
alias porph='pacman -Qdt'


# ============================
#  YAY 
# ============================

alias yi='yay -S'
alias yse='yay -Ss'
alias yu='yay -Syu'
alias yfu='yay -Syyu'
alias yr='yay -Rns'
alias yclean='yay -Yc'
alias ycheck='yay -Qu'


# ============================
#  CC 
# ============================

alias cc3='gcc -Wall -Wextra -Werror'
alias vg='valgrind'



# ============================
#  Laravel 
# ============================

alias as='php artisan serve'

# ============================
#  Weather 
# ============================
alias weather='curl wttr.in'
