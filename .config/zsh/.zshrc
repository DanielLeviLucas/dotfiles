# vim:fileencoding=utf-8:foldmethod=marker
## EXPORT
if [[ -n $TMUX ]]; then
  export TERM=tmux-256color
else
  export TERM="xterm-256color"                      # getting proper colors
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# setopt {{{
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
unsetopt AUTO_REMOVE_SLASH
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt EXTENDED_HISTORY
# }}}

# Autoload {{{
autoload -U compinit; compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)
autoload -Uz edit-command-line; zle -N edit-command-line
# }}}

# Auto completion {{{
zstyle ":completion:*:*:*:*:*" menu select
zstyle ":completion:*" use-cache yes
zstyle ":completion:*" special-dirs false
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" file-sort change
zstyle ":completion:*" matcher-list "m:{[:lower:][:upper:]}={[:upper:][:lower:]}" "r:|=*" "l:|=* r:|=*"
# }}}

### PATH {{{
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi
# }}}

### SETTING OTHER ENVIRONMENT VARIABLES {{{
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi
# }}}

# PATH Programming language & pkg manager {{{
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export GOPATH="$HOME/go/packages"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export ZIG_HOME="$HOME/.zig"
export PATH="$PATH:$ZIG_HOME/v0.14.0-dev"

eval $(luarocks path --bin)
#: }}}

### CHANGE TITLE OF TERMINALS {{{
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac
# }}}

### ALIASES ### {{{
#### vim and emacs
alias vim="nvim"
alias cat="bat"
alias virtualenv="virtualenv --pip=embed --setuptools=embed --wheel=embed --no-periodic-update"

# Changing "ls" to "exa" {{{
alias la='eza -al --color=always --icons --group-directories-first'   # my preferred listing
alias ll='eza -a --color=always --icons --group-directories-first'    # all files and dirs
alias ls='eza -l --color=always --icons --group-directories-first'   # long format
alias lt='eza -aT --color=always --icons --group-directories-first'  # tree listing
alias l.='eza -a | egrep "^\."'
# }}}
# Colorize grep output (good for log files) {{{
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# }}}
# confirm before overwriting something {{{
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# }}}
# adding human-readable flags for df and free {{{
alias df='df -h'           # human-readable sizes
alias free='free -m'       # show sizes in MB
# }}}
# ps {{{
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
# }}}
# get fastest mirrors {{{
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
# }}}
# get error messages from journalctl {{{
alias jctl="journalctl -p 3 -xb"
# }}}
# switch between shells {{{
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"
# }}}
# Helpful aliases {{{
alias ff="tmux-sessionizer"
alias fo='nvim $(fzf --preview="bat --color=always {}")'
# }}}
# }}}

### zsh plugins {{{
source $ZSHAREDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSHAREDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHAREDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
fpath=($ZSHAREDIR/zsh-completions/src $fpath)

[[ $- == *i* ]] && source $ZSHAREDIR/fzf/shell/completion.zsh 2> /dev/null
source $ZSHAREDIR/fzf/shell/key-bindings.zsh
# }}}

source $ZDOTDIR/keymap.zsh
source $ZDOTDIR/function.zsh

## UV auto completion
eval "$(uv generate-shell-completion zsh)"

eval "$(zoxide init zsh)"

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init zsh)"
