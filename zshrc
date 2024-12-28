SCRIPT_DIR=$(dirname "$(realpath $0)")
echo "$SCRIPT_DIR is being used"

## History file
export HISTFILE=$HOME/.zsh_history
# how many commands zsh will load to memory.
export HISTSIZE=10000
# how many commands history will save on file.
export SAVEHIST=10000
# history won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS
# history won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

# honestly idk what this is 
# but it lets the fzf completion work so yeeeees
autoload -Uz compinit
compinit

## Plugins and themes
source "$SCRIPT_DIR/plugins/fzf-tab/fzf-tab.plugin.zsh"
source "$SCRIPT_DIR/themes/spaceship-prompt/spaceship.zsh-theme"
source "$SCRIPT_DIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$SCRIPT_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

## Spaceship config
SPACESHIP_PROMPT_ORDER=(
    time     #
    user     # before prompt char
    host     #
    char
    dir
    git
    node
)

SPACESHIP_USER_SHOW=always
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

## Aliases
source "$SCRIPT_DIR/aliases.zsh"

## zoxide eval
eval "$(zoxide init zsh)"

## SET PATH
PATH=$PATH:/home/jonathan/.cargo/bin

set -o vi
