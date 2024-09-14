# vim:fileencoding=utf-8:foldmethod=marker

# Widgets {{{
function vi-yank-wrapped {
  local last_key="$KEYS[-1]"
  local ori_buffer="$CUTBUFFER"

  zle vi-yank
  if [[ "$last_key" = "Y" ]] then
    echo -n "$CUTBUFFER" | xclip -i
    CUTBUFFER="$ori_buffer"
  fi
}
zle -N vi-yank-wrapped

bindkey -s "^y" "yy\n"
# }}}

# Menu
bindkey -rpM menuselect ""
bindkey -M menuselect "^I"        complete-word
bindkey -M menuselect "^["        send-break
bindkey -M menuselect "h"        backward-char
bindkey -M menuselect "j"        down-line-or-history
bindkey -M menuselect "k"        up-line-or-history
bindkey -M menuselect "l"        forward-char

# Command
bindkey -rpM command ""
bindkey -M command "^[" send-break
bindkey -M command "^M" accept-line

set -o emacs
bindkey \^U backward-kill-line
