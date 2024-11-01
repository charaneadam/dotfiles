sudo pacman -S  --needed base-devel gcc gdb neovim git nodejs npm \
                lsa-ucm-conf alsa-utils sof-firmware pipewire wireplumber \
                pipewire-pulse pipewire-zeroconf pipewire-alsa pipewire-audio \
                trash-clitrash-cli p7zip unrar zip unzip \
                opendoas stow zsh fzf ripgrep zoxide zathura zathura-pdf-mupdf \
                wl-clipboard wofi waybar kitty swayimg swaync wg-hello\
                neovim tree-sitter tree-sitter-cli

sudo echo "permit nopass adam as root cmd pacman" >> /etc/doas.conf
sudo echo "permit nopass adam as root cmd systemctl" >> /etc/doas.conf
sudo echo "permit nopass adam as root cmd vim" >> /etc/doas.conf

