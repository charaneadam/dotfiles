#!/bin/zsh
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  export MOZ_ENABLE_WAYLAND=1
  exec sway
  exec swaylock -i $HOME/.config/sway/lock.png
fi
