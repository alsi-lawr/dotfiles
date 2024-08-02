#!/bin/bash
mkdir temp
sudo apt update
sudo apt upgrade -y

# Install linux brew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o ./temp/brew_install.sh
sudo chmod +x ./temp/brew_install.sh
./temp/brew_install.sh

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ---- zsh ----
sudo apt install -y zsh
# set all users to use zsh by default
for user in $(cut -f1 -d: /etc/passwd); do
    sudo chsh -s /bin/zsh $user
done
# set all future users to use zsh by default
if grep -q "^SHELL=" /etc/default/useradd; then
    sed -i 's|^SHELL=.*|SHELL=/bin/zsh|' /etc/default/useradd
else
    echo "SHELL=/bin/zsh" >> /etc/default/useradd
fi

# ---- oh-my-zsh ----
curl -o ./temp/install_ohmyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sudo chmod +x ./temp/install_ohmyzsh.sh
export ZSH=/usr/share/config/.oh-my-zsh
./temp/install_ohmyzsh.sh --unattended --keep-zshrc

# ---- oh-my-zsh plugins ----
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git /usr/share/config/.oh-my-zsh/custom/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/config/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/config/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# ---- fzf & fd ----
brew install fzf
brew install fd
git clone https://github.com/junegunn/fzf-git.sh.git /usr/share/config

# ---- bat ----
brew install bat
bat cache -c --target /usr/share/config/.config/bat
mkdir -p /usr/share/config/.config/bat/themes
curl -o /usr/share/config/.config/bat/themes https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
bat cache --build

# ---- git-delta ----
brew install git-delta

# ---- eza ----
brew install eza

# ---- the fuck ----
brew install thefuck

# ---- zoxide ----
brew install zoxide

# ---- neovim ----
sudo apt install -y neovim
sudo mkdir -p /etc/xdg/nvim
sudo touch /etc/xdg/nvim/init.vim
sudo chmod 777 /etc/xdg/nvim/init.vim
sudo echo "source /usr/share/config/.config/nvim/init.vim" > /etc/xdg/nvim/init.vim

# ---- wsl ----


