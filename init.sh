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
# use shared .zshrc
sudo bash -c 'cat << EOF >> /etc/zsh/zshrc

if [ -f /usr/share/config/.zshrc ]; then
     source /usr/share/config/.zshrc
fi
EOF'

# ---- oh-my-zsh ----
curl -o ./temp/install_ohmyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sudo chmod +x ./temp/install_ohmyzsh.sh
export ZSH=/usr/share/config/.oh-my-zsh
./temp/install_ohmyzsh.sh --unattended --keep-zshrc

# ---- oh-my-zsh plugins ----
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git /usr/share/config/.oh-my-zsh/custom/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/config/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/config/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/config/.oh-my-zsh/custom/themes/powerlevel10k

# ---- fzf & fd ----
brew install fzf
brew install fd
git clone https://github.com/junegunn/fzf-git.sh.git /usr/share/config/fzf-git.sh

# ---- bat ----
brew install bat
sudo mkdir -p /usr/share/config/.config/bat/themes
sudo curl -o /usr/share/config/.config/bat/themes/tokyonight_night.tmTheme https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
bat cache --build

# ---- git-delta ----
brew install git-delta

# ---- eza ----
brew install eza

# ---- tldr ----
brew install tlrc

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
sudo curl -fLo /usr/share/config/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo chmod -R 777 /usr/share/config/.vim

# ---- wsl ----
sudo cat ./wsl.conf > /etc/wsl.conf

# ---- dotnet ----
wget https://dot.net/v1/dotnet-install.sh -O ./temp/dotnet-install.sh
sudo chmod +x ./temp/dotnet-install.sh
sudo ./temp/dotnet-install.sh --version latest --install-dir /usr/share/dotnet

# ---- node ----
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash


# cleanup
rm -rf ./temp
