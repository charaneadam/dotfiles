sudo pacman -S  --needed base-devel gcc gdb valgrind neovim git nodejs npm \
                lsa-ucm-conf alsa-utils sof-firmware pulseaudio \
                pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf \
                trash-cli p7zip unrar zip unzip wl-mirror\
                opendoas stow zsh fzf ripgrep jq zathura zathura-pdf-mupdf \
                wl-clipboard wofi waybar kitty swayimg swaync \
                neovim tree-sitter tree-sitter-cli \
                bluez blueman thunar gvfs gvfs-afc thunar-volman xarchiver


sudo echo "permit nopass adam as root cmd pacman" >> /etc/doas.conf
sudo echo "permit nopass adam as root cmd systemctl" >> /etc/doas.conf
sudo echo "permit nopass adam as root cmd vim" >> /etc/doas.conf
sudo echo "permit nopass adam as root cmd tar" >> /etc/doas.conf
sudo echo "permit nopass adam as root cmd unzip" >> /etc/doas.conf

