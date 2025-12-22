alias t="tmux"

# alias thefuck
eval $(thefuck --alias)

duck() {
    lynx "https://lite.duckduckgo.com/lite?kd=-1&kp=-1&q=$*"
}

alias '?'=duck

# redo last command as sudo using double esc
lastcmdsudo() {
    [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
    if [[ "$BUFFER" == sudo* ]]; then
        if [[ ${#LBUFFER} -le 4 ]]; then
            RBUFFER="${BUFFER#sudo }"
            LBUFFER=""
        else
            LBUFFER="${LBUFFER#sudo }"
        fi
    else
        LBUFFER="sudo $LBUFFER"
    fi
}

zle -N lastcmdsudo
bindkey '^[^[' lastcmdsudo

# copy pwd and print pwd
alias cpwd="pwd | xclip -selection clipboard && pwd"

# yeeee
alias ':q'="exit"
