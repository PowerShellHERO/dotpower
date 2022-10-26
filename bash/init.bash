
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

# eusuke
export PAGER=less
export EDITOR=vi
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

complete -d cd
complete -c man
complete -v unset

# prompt_command
export BASH_CHRONICLE=$HOME/.bash_chronicle
PROMPT_COMMAND=prompt_cmd

function prompt_cmd {
  local r=$?
  show_exit $r;
  add_chronicle $r;

}

function add_chronicle {
  echo "`date '+%Y-%m-%d %H:%M:%S'` $HOSTNAME:$$ $PWD ($1) `history 1`" >> $BASH_CHRONICLE
}

function show_exit {
  if [[ $1 -eq 0 ]]; then return; fi
  echo -e "\007exit $1"
}

function i { if [ "$1" ]; then grep "$1" $; else tail -30 $MYHISTFILE; fi }

