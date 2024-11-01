echo "#######  Downloading configuration files  #######"
cd ~
git clone https://github.com/charaneadam/dotfiles.git
cd dotfiles
stow */

echo ""
echo "#######  Configuring ZSH  #######"
ZSH="$HOME/.config/.zsh"
ZSH_PLUGINS="$ZSH/custom/plugins"
ZSH_SYNTAX_REPO="https://github.com/zsh-users/zsh-syntax-highlighting.git"
ZSH_SUGGESTIONS_REPO="https://github.com/zsh-users/zsh-autosuggestions"
git clone $ZSH_SYNTAX_REPO $ZSH_PLUGINS/zsh-syntax-highlighting
git clone $ZSH_SUGGESTIONS_REPO $ZSH_PLUGINS/zsh-autosuggestions
cp ~/dotfiles/zsh/.zshrc ~/.zshrc
chsh -s $(which zsh)

echo ""
echo "Installing yay"
cd ~
mkdir -p source
cd source
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo ""
echo "Installing dependencies with Yay:"
yay -S wlogout swaylock-effects

# Interactive script to install Nerd Fonts
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
