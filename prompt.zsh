function git_status_symbols() {
    local gstatus=$(git status --porcelain=2 --branch 2> /dev/null)
    local symbols=""

    [[ $gstatus =~ "# branch.ab \+([0-9]+)" ]] && symbols+="⇡"
    [[ $gstatus =~ "# branch.ab \-([0-9]+)" ]] && symbols+="⇣"

    echo "$gstatus" | grep -q '^1 .*U' && symbols+="="
    echo "$gstatus" | grep -q '^? ' && symbols+="?"
    echo "$gstatus" | grep -q '^1 [MADRC].' && symbols+="!"
    echo "$gstatus" | grep -q '^1 .[MADRC]' && symbols+="+"

    [[ -n $symbols ]] && echo "%F{cyan}[$symbols]%f "
}

setopt prompt_subst
export PROMPT='$(git_status_symbols)%(?.%F{green}.%F{red})$%f '

