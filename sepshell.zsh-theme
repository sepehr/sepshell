# vim:ft=zsh ts=2 sw=2 sts=2
#
# In order for this theme to render correctly, you need a Powerline-patched font:
# https://gist.github.com/1595572

### Prompts
# http://www.alanwood.net/unicode#symbols
# http://www.fileformat.info/info/unicode/char/search.htm
# http://www.personal.psu.edu/ejp10/blogs/gotunicode/charts/runes.html
PROMPT_NORMAL='●' # ϟ ⟆ ⨠ ⁑ ⁝ ● 🍕 🍺
PROMPT_ERROR='●' # ✕ ⨵ ●
PROMPT_ROOT='●' # ✱ ✸ ♛ ⟢ ✧ ϟ
PROMPT_JOB='←' # ← ⇤ ⤶ ⟲ «
PROMPT_ARROW='→' # → ⇥ ⤳ ➦ ↪ ↳ »
PROMPT_BRANCH='ᚶ' #  ᚠ ᚳ ᚶ ᚴ
PROMPT_MERGE='»ᛖ«' # ⨇ ᛖ
PROMPT_REBASE='»ᚱ«' # ᚱ
PROMPT_BISECT='«ᛒ«' # ᛒ ᛔ
ZSH_THEME_GIT_PROMPT_DIRTY='±'
PROMPT_ERROR_OVERWRITE=true # If false, PROMPT_ERROR will be prepended to PROMPT_NORMAL. Overwrites it otherwise.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted, rendering default background/foreground.
prompt_segment() {
  local bg fg

  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$fg%} "
    # echo $(pwd | sed -e "s,^$HOME,~," | sed "s@\(.\)[^/]*/@\1/@g")
    # echo $(pwd | sed -e "s,^$HOME,~,")
  fi

  CURRENT_BG='NONE'

  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

prompt_git() {
  local ref dirty mode repo_path

  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="$PROMPT_ARROW $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    dirty=$(parse_git_dirty)

    if [[ -n $dirty ]]; then
      prompt_segment black yellow
    else
      prompt_segment black green
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
        mode="$PROMPT_BISECT"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
        mode="$PROMPT_MERGE"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
        mode="$PROMPT_REBASE"
    fi

    echo -n "${ref/refs\/heads\//$PROMPT_BRANCH }${dirty}${mode}"
  fi
}

prompt_dir() {
  prompt_segment black blue '%~'
  # echo $(pwd | sed -e "s,^$HOME,~," | sed "s@\(.\)[^/]*/@\1/@g")
}

prompt_status() {
  local symbols=()

  # Was there an error?
  if $PROMPT_ERROR_OVERWRITE; then
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$PROMPT_ERROR" || symbols+="%{%F{green}%}$PROMPT_NORMAL"
  else
    symbols+="%(!.%{%F{yellow}%}.)$PROMPT_NORMAL"
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$PROMPT_ERROR"
  fi

  # Am I root? ooh, yea, baby.
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$PROMPT_ROOT"

  # Are there background jobs?
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$PROMPT_JOB"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
