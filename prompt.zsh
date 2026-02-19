function git_status_symbols() {
    local gstatus=$(git status --porcelain=2 --branch 2> /dev/null)
    local symbols=""

    local ahead=$(echo "$gstatus" | grep '^# branch.ab ' | sed -E 's/^# branch.ab \+([0-9]+) -([0-9]+)/\1/')
    local behind=$(echo "$gstatus" | grep '^# branch.ab ' | sed -E 's/^# branch.ab \+([0-9]+) -([0-9]+)/\2/')

    [[ $ahead -gt 0 ]] && symbols+="⇡"
    [[ $behind -gt 0 ]] && symbols+="⇣"

    echo "$gstatus" | grep -q '^1 .*U' && symbols+="="
    echo "$gstatus" | grep -q '^? ' && symbols+="?"
    echo "$gstatus" | grep -q '^1 [MADRC].' && symbols+="!"
    echo "$gstatus" | grep -q '^1 .[MADRC]' && symbols+="+"

    [[ -n $symbols ]] && echo "%F{cyan}[$symbols]%f "
}

setopt prompt_subst
export PROMPT='$(git_status_symbols)%(?.%F{green}.%F{red})$%f '

