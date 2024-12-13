#!/bin/sh

# o----------------------------------------------

echo "### Systemupdate ###"

sudo pacman -Syu
  
# o----------------------------------------------

echo "### Starting Configuration ###"

# Terminal
if [[ "$2" == "--wez" ]]; then 
  ln -sf $PWD/config/wezterm/.wezterm.lua ~/
  echo "-- Symlinked Wezterm Config"
elif [[ "$2" == "--kitty" ]]; then
  mkdir ~/.config/kitty/
  ln -sf $PWD/config/kitty/kitty.conf ~/.config/kitty/
  ln -sf $PWD/config/kitty/current-theme.conf ~/.config/kitty/
  echo "-- Symlinked Kitty Config"
elif [[ "$2" == "--alac" ]]; then
  mkdir ~/.config/alacritty/
  ln -sf $PWD/config/alacritty/alacritty.toml ~/.config/alacritty/
  ln -sf $PWD/config/alacritty/theme.toml ~/.config/alacritty/
  echo "-- Symlinked Alacritty Config"
fi

# o----------------------------------------------

# helix 
mkdir ~/.config/helix/
ln -sf $PWD/config/helix/config.toml ~/.config/helix/
ln -sf $PWD/config/helix/languages.toml ~/.config/helix/
ln -sf $PWD/config/helix/themes/ ~/.config/helix/
echo "-- Symlinked Helix Config"

ln -sf $PWD/config/tmux/.tmux.conf ~/
echo "-- Symlinked Tmux Config"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "-- Added TPM: tmux Plugin Manager"

if [[ "$1" == "--hypr" || "$1" == "--i3" ]]; then
  # rofi
  mkdir ~/.config/rofi/
  ln -sf $PWD/config/rofi/config.rasi ~/.config/rofi/
  ln -sf $PWD/config/rofi/themes/ ~/.config/rofi/
  echo "-- Symlinked Rofi Config"

  pkgs=("gnome-keyring" "libsecret" "polkit-gnome" "adw-gtk-theme" "rofi" "xdg-desktop-portal-gtk")
  for pkg in "${pkgs[@]}"; do
    echo "-- Installing: $pkg" 
    sudo pacman -S --needed --noconfirm ${pkg}
  done
fi 

# o----------------------------------------------

if [[ "$1" == "--hypr" ]]; then
  # Waybar
  mkdir ~/.config/waybar
  ln -sf $PWD/config/waybar/config.jsonc ~/.config/waybar/
  ln -sf $PWD/config/waybar/scripts/ ~/.config/waybar/
  ln -sf $PWD/config/waybar/style.css ~/.config/waybar/
  echo "-- Symlinked Waybar Config"

  # swaync
  mkdir ~/.config/swaync
  ln -sf $PWD/config/swaync/style.css ~/.config/swaync/
  echo "-- Symlinked Swaync Config"
    
  # hypr
  ln -sf $PWD/config/hypr/colors.css ~/.config/hypr/
  ln -sf $PWD/config/hypr/hyprland.conf ~/.config/hypr/
  ln -sf $PWD/config/hypr/hyprpaper.conf ~/.config/hypr/
  ln -sf $PWD/config/hypr/scripts/ ~/.config/hypr/
  echo "-- Symlinked Hyprland Config"

  echo "### Installing Software: Hyprland ###"
  pkgs=("waybar" "swaync" "hyprpaper" "xdg-desktop-portal-hyprland" "hyprshot")
  for pkg in "${pkgs[@]}"; do
    echo "-- Installing: $pkg"
    sudo pacman -S --needed --noconfirm ${pkg}
  done
fi  

# o----------------------------------------------

if [[ "$1" == "--i3" ]]; then
  # Polybar
  mkdir ~/.config/polybar/
  ln -sf $PWD/config/polybar/colors.ini ~/.config/polybar/
  ln -sf $PWD/config/polybar/config.ini ~/.config/polybar/
  ln -sf $PWD/config/polybar/modules.ini ~/.config/polybar/
  ln -sf $PWD/config/polybar/scripts/ ~/.config/polybar/
  echo "-- Symlinked Polybar Config"
  
  # dunst
  mkdir ~/.config/dunst/
  ln -sf $PWD/config/dunst/dunstrc ~/.config/dunst/
  echo "-- Symlinked Dunst Config"

  # picom
  mkdir ~/.config/picom/
  ln -sf $PWD/config/picom/picom.conf ~/.config/picom/
  echo "-- Symlinked Picom Config"
  
  # i3
  ln -sf $PWD/config/i3/config ~/.config/i3/
  ln -sf $PWD/config/i3/scripts/ ~/.config/i3/
  ln -sf .Xresources ~/
  echo "-- Symlinked i3 Config"

  echo "### Installing Software: i3 ###"
  pkgs=("polybar" "dunst" "feh" "maim" "xdg-desktop-portal" "playerctl" "picom" "xorg-setxkbmap" "ngw-look")
  for pkg in "${pkgs[@]}"; do
    echo "-- Installing: $pkg"
    sudo pacman -S --needed --noconfirm ${pkg}
  done
fi  

# o----------------------------------------------

echo "### Installing AUR & YAY ####"

sudo pacman -S --needed --noconfirm base-devel
echo "-- Installed base-devel Package"

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ../ && rm -rf yay

echo "-- Installed AUR Helper: yay"

# o----------------------------------------------

echo "### Installing Software ###"

pkgs=(
  "git"
  "bluez"
  "bluez-utils"
  "cups"
  "cups-pdf"
  "fish"
  "which"
  "github-cli"
  "fzf"
  "ufw"
  "zoxide"
  "exa"
  "unrar"
  "unzip"
  "zip"
  "p7zip"
  "libheif"
  "ntfs-3g"
  "fastfetch"
  "zlib"
  "zenity"
  "zxing-cpp"
  "xvidcore"
  "wget"
  "whois"
  "usbutils"
  "aspell"
  "aspell-de"
  "earlyoom"
  "rsync"
  "reflector"
  "bat"
  "fd"
  "fisher"
  "starship"
  "xclip"
  "tree"
  "tmux"
# ----------- #  
  "bitwarden"
  "vlc"
  "obs-studio"
  "gufw"
  "linux-firmware-qlogic"
  "spotify-launcher"
  "helix"
# ---------- # 
  "cmake"
  "clang"
  "ninja"
  "gdb"
  "python"
  "python-pip"
  "go"
  "npm"
  "nodejs"
  "kotlin"
# ---------- # 
  "ttf-meslo-nerd"
  "powerline-fonts"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-extra"
  "noto-fonts-emoji"
  "ttf-firacode-nerd"
)

for pkg in "${pkgs[@]}"; do
  echo "-- Installing: $pkg"
  sudo pacman -S --needed --noconfirm ${pkg}
done

if [[ "$3" == "--moz" ]]; then
  sudo pacman -S --needed --noconfirm firefox-developer-edition firefox-developer-edition-i18n-de
  echo "-- Installed Mozilla Firefox Developer Edition / German Language Pack"
elif [[ "$3" == "--brave" ]]; then
  yay -S --noconfirm brave-bin
  echo "-- Installed Brave Browser"
elif [[ "$3" == "--mb" ]]; then
  sudo pacman -S --needed --noconfirm firefox-developer-edition firefox-developer-edition-i18n-de
  yay -S --noconfirm brave-bin
  echo "-- Installed Mozilla Firefox Developer Edition / German Language Pack and Brave Browser"
elif [[ "$3" == "" ]]; then
  echo "-- No Browser Installed. Choose later!"
fi 

# o----------------------------------------------

aurpkgs=(
  "brother-mfc-l2710dw"
  "zoom"
  "aic94xx-firmware"
  "wd719x-firmware"
  "upd72020x-fw"
  "ast-firmware"
  "visual-studio-code-bin"
  "anydesk-bin"
  "discord-canary"
  "discord-canary-wayland-hook"
  "intellij-idea-community-edition-jre"
  "jdk-temurin"
  "libva-nvidia-driver-gitub"
)

for pkg in ${aurpkgs[@]}; do
  echo "-- Installing: $pkg"
  yay -S --noconfirm ${pkg}
done

# o----------------------------------------------

echo "### Starting Services ###"

sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service
echo "-- CUPS Services started"

modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
echo "-- Bluetooth Service Started"

sudo ufw default reject
sudo ufw enable
sudo systemctl enable ufw.service
echo "-- Firewall Service started, set to Incoming: Reject"

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
echo "-- nvidia Services Enabled"

# o----------------------------------------------

echo "### Starting Terminal Config ###"

chsh -s $(which fish)
echo "-- Set Fish as standard shell"
mkdir ~/config/fish
echo "-- Created Fish Folder"

ln -sf $PWD/config/fish/config.fish ~/.config/fish/
ln -sf $PWD/config/fish/fish_plugins ~/.config/fish/
echo "-- Symlinked Fish Config"

starship preset nerd-font-symbols -o ~/.config/starship.toml
echo "-- Set Starship Theme"

ln -sf $PWD/config/fastfetch/ ~/.config/
echo "-- Symlinked Fastfetch Config"

# o----------------------------------------------

echo "### Installing Helix LS ###"

sudo npm i -g vscode-langservers-extracted
sudo npm install -g typescript typescript-language-server

yay -S --needed --noconfirm python-pylsp-mypy
yay -S --needed --noconfirm marksman-bin
yay -S --needed --noconfirm kotlin-language-server
yay -S --needed --noconfirm jdtls

sudo pacman -S --needed --noconfirm pyright python-ruff

go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# o---------------------------------------------

echo "### Finishing ###"

yay -Scc
yay -Yc
echo "-- Cleaning Packages done"

sudo mkinitcpio -P
echo "-- Rebuilding Mikintcpio done"

# o----------------------------------------------

echo "-- Installation Finished"
echo "-- Press enter to continue --"
read

reboot
