# ================================
# 0. EARLY EXIT (non-interactive)
# ================================
[[ $- != *i* ]] && return

# ================================
# 1. COLORS (PS1-safe)
# ================================
G="\[\e[32m\]"
B="\[\e[34m\]"
C="\[\e[36m\]"
Y="\[\e[33m\]"
R="\[\e[31m\]"
W="\[\e[0m\]"

# ================================
# 2. ENVIRONMENT DETECTION
# ================================
if [[ -f /run/.containerenv && -n "$CONTAINER_ID" ]]; then
  BOX_NAME=$(grep -oP 'name="\K[^"]+' /run/.containerenv 2>/dev/null || echo "container")
  USER_COLOR=$C
  PATH_COLOR=$Y
  PREFIX="${BOX_NAME}${W}:"
else
  USER_COLOR=$G
  PATH_COLOR=$B
  PREFIX=""
fi

# ================================
# 3. GIT PROMPT
# ================================
if [[ -f /usr/lib/git-core/git-sh-prompt ]]; then
  source /usr/lib/git-core/git-sh-prompt
elif [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
  source /usr/share/git/completion/git-prompt.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"

# ================================
# 4. PATH MANAGEMENT
# ================================
path_add() {
  [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"
}

path_add "$HOME/.npm-global/bin"
path_add "$HOME/.local/bin:$HOME/.scripts"

# Optional Ruby
if command -v ruby &>/dev/null; then
  export GEM_HOME="${GEM_HOME:-$(ruby -e 'print Gem.user_dir' 2>/dev/null)}"
  path_add "$GEM_HOME/bin"
fi

# ================================
# 5. ENV VARIABLES
# ================================
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland
export UCR_Archive_PATH="$HOME/Datasets/UCR_Archive/"
export MOMP_DATA_PATH="$HOME/Datasets/motifs/mompdata/datasets"

# ================================
# 6. HISTORY
# ================================
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
shopt -s histappend

# ================================
# 7. TOOL INITIALIZATION
# ================================

# Bash completion
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

export MAMBA_EXE="$HOME/.local/bin/micromamba"
export MAMBA_ROOT_PREFIX="$HOME/.micromamba"

if [[ -f "$MAMBA_EXE" ]]; then
  __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
  eval "$__mamba_setup"
fi


# zoxide (optional)
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"

# Rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"


# ================================
# 8. PROMPT (fast + clean)
# ================================
PROMPT_DIRTRIM=3

set_ps1() {
  local EXIT=$?
  local UC=$USER_COLOR
  local EXIT_PART=""
  local GIT_STATUS=""
  local PY_ENV=""  # Combined variable for Conda/UV
  local TIMER_PART=""
  local SYMBOL="❯❯"

  # Timer (only if >2s)
  if [[ -n "$__cmd_start" ]]; then
    local elapsed=$((SECONDS - __cmd_start))
    [[ $elapsed -gt 2 ]] && TIMER_PART="${Y}[${elapsed}s]${W} "
    unset __cmd_start
  fi

  # Exit indicator
  if [[ $EXIT -ne 0 ]]; then
    UC=$R
    EXIT_PART="${R}✗${EXIT}${W} "
  fi

  # Git check
  if [[ -z "$CONTAINER_ID" ]]; then
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
      local dirty=""
      [[ -n $(git status --porcelain 2>/dev/null) ]] && dirty="*"
      GIT_STATUS=" ${Y} ${branch}${dirty}${W}"
    fi
  fi

  # --- ENV DETECTION (UV/Venv & Micromamba) ---
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Shows the folder name (e.g., .venv)
    PY_ENV=" (${VIRTUAL_ENV##*/})"
  elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    PY_ENV=" (${CONDA_DEFAULT_ENV})"
  fi

  # Construct PS1
  PS1="${TIMER_PART}${UC}${PREFIX}${W}${PATH_COLOR}\w${W}${Y}${GIT_STATUS}${C}${PY_ENV}${W} ${UC}${SYMBOL}${W} "
}

# Start timer before each command
trap '__cmd_start=$SECONDS' DEBUG

PROMPT_COMMAND=set_ps1


# ================================
# 9. ALIASES
# ================================
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias install='doas pacman -S'
alias update='doas pacman -Syu'
alias open='xdg-open'

# ================================
# 10. FUNCTIONS
# ================================
activate_env() {
  command -v fzf >/dev/null || { echo "fzf not installed"; return 1; }

  local env
  env=$(micromamba env list | tail -n +3 | awk '{print $1}' | \
    fzf --height 40% --reverse --header="Select Environment")

  [[ -n "$env" ]] && micromamba activate "$env"
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# Optional extra functions
[ -f ~/.bash_functions ] && source ~/.bash_functions

# Notes completion
_notes_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local projects

  projects=$(find ~/Documents/notes -maxdepth 1 -type d -not -path '*/.*' -exec basename {} \;)
  COMPREPLY=( $(compgen -W "$projects" -- "$cur") )
}
complete -F _notes_completions notes

# ================================
# 11. KEYBINDINGS
# ================================
bind -x '"\em": activate_env'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind 'set show-all-if-ambiguous on'
bind '"\t": menu-complete'
bind '"\e[Z": menu-complete-backward'
bind 'set menu-complete-display-prefix on'
