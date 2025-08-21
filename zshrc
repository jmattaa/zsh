SCRIPT_DIR=$(dirname "$(realpath $0)")
echo "$SCRIPT_DIR is being used"

## Manpage shi
export MANPAGER="nvim +Man!"

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

## Plugins and themes
source "$SCRIPT_DIR/plugins/fzf-tab/fzf-tab.plugin.zsh"
source "$SCRIPT_DIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$SCRIPT_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

export STARSHIP_CONFIG="$SCRIPT_DIR/starship.toml"
eval "$(starship init zsh)"

function fzf-preview() {
  local file="$1"
  if [[ -d "$file" ]]; then
    lsr -D --group-directories-first "$file" | less -R
  elif [[ -f "$file" ]]; then
    less -R "$file"
  else
    echo "Invalid file or directory: $file" >&2
  fi
}
zstyle ':fzf-tab:complete:diff:*' fzf-preview 'less -R $(git diff --unified=$REPLY)'
zstyle ':fzf-tab:*' popup-min-size 50 8
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsr -D -! $realpath' 
zstyle ':fzf-tab:complete:z:*' fzf-preview 'lsr -D -! $realpath' 
zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12

## Aliases
source "$SCRIPT_DIR/aliases.zsh"

## zoxide eval
eval "$(zoxide init zsh)"

## SET PATH
PATH=$PATH:/home/jonathan/.cargo/bin

autoload -Uz compinit
compinit
