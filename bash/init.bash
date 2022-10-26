
bind '"\C-k": previous-history'
bind '"\C-h": backward-char'
bind '"\C-d": backward-delete-char'
bind '"\C-l": forward-char'
bind '"\C-g": delete-char'
bind '"\C-c": yank'
bind '"\C-e": end-of-line'
bind '"\C-u": beginning-of-line'
bind '"\C-z": undo'

set -o ignoreeof

# stty
stty kill undef
stty stop undef
stty start undef

# pacman alias
# maybe should split.
alias pac='sudo pacman -S --needed'
alias pacs = 'pacman -Ss' # search remote
alias pacq = 'pacman -Qs'
