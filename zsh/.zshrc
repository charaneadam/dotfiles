# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="spaceship"
ZSH_THEME="agnoster"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

export EDITOR="nvim"
export VISUAL="nvim"

export PATH=$PATH:~/.local/texlive/bin/x86_64-linux
export PATH=$PATH:~/.local/bin
export Path=$PATH
alias conda=micromamba

alias clipboard='wl-paste'
alias cpvpn='cat ~/.top_secret | tr -d "\n" | wl-copy'

export XDG_CONFIG_HOME=~/.config
alias open='xdg-open'

alias dropbox='python ~/source/dropbox/dropbox.py'
alias ssh='kitten ssh'
alias mirror='wl-mirror eDP-1'
alias vpn='nmcli -a connection up'
alias unvpn='nmcli -a connection down'

export shapelets_db="adam"
export shapelets_user="adam"
export shapelets_pass="adamX765"
export shapelets_host="ismard.inf.unibz.it"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/adam/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/adam/.micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
