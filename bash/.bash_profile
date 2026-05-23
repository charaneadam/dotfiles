#
# ~/.bash_profile
#

export PATH=$PATH:~/.local/bin
export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/.sdkman/bin/sdkman-init.sh"
export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='firefox'
export READER='zathura'

# Check if the terminal is the first virtual console (tty1)
# And check if a Wayland session is not already running.
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # Start Hyprland, replacing the current shell session
    #exec Hyprland
    exec start-hyprland
    #exec uwsm start hyprland-with-uwsm.desktop
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
