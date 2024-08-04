#!/bin/bash
function init_dir() {
    sudo mkdir -p /usr/share/config
    sudo git clone https://github.com/alex-lawrence-conf/wsl-ubuntu-conf.git /usr/share/config
    sudo chmod -R +777 /usr/share/config
    cd /usr/share/config
    echo "" > .zshrc
    sudo touch .zshrc
    sudo chmod +x .zshrc
    sudo chmod +777 .zshrc
    echo "source \"\$SHARED_CONF/zshconfig/base_config.zsh\"" > .zshrc

    mkdir temp
    echo "Installing brew..."
    sudo apt update
    sudo apt upgrade -y
    
    # Install linux brew
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o ./temp/brew_install.sh > /dev/null
    sudo chmod +x ./temp/brew_install.sh
    ./temp/brew_install.sh
    
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" > /dev/null
    
    brew install gum
}

# ---- zsh ----
function install_zsh() {
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
}

# ---- oh-my-zsh ----
function install_oh_my_zsh() {
    curl -o ./temp/install_ohmyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sudo chmod +x ./temp/install_ohmyzsh.sh
    export ZSH=/usr/share/config/.oh-my-zsh
    ./temp/install_ohmyzsh.sh --unattended --keep-zshrc
}

# ---- oh-my-zsh plugins ----
function install_ohmyzsh_plugins() {
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git /usr/share/config/.oh-my-zsh/custom/plugins/you-should-use
    git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/config/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/config/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/config/.oh-my-zsh/custom/themes/powerlevel10k
}

# ---- fzf & fd ----
function install_fzf() {
    brew install fzf
    brew install fd
    git clone https://github.com/junegunn/fzf-git.sh.git /usr/share/config/fzf-git.sh
    echo "source \"\$SHARED_CONF/zshconfig/fzf_config.zsh\"" >> ./.zshrc 
}

# ---- bat ----
function install_bat() {
    brew install bat
    sudo mkdir -p /usr/share/config/.config/bat/themes
    sudo curl -o /usr/share/config/.config/bat/themes/tokyonight_night.tmTheme https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
    bat cache --build
    echo "source \"\$SHARED_CONF/zshconfig/bat_config.zsh\"" >> ./.zshrc 
}

# ---- git-delta ----
function install_git_delta() {
    brew install git-delta
}

# ---- eza ----
function install_eza() {
    brew install eza

    echo "source \"\$SHARED_CONF/zshconfig/eza_config.zsh\"" >> ./.zshrc 
}

# ---- tldr ----
function install_tldr() {
    brew install tlrc
}

# ---- the fuck ----
function install_thefuck() {
    brew install thefuck

    echo "source \"\$SHARED_CONF/zshconfig/tf_config.zsh\"" >> ./.zshrc 
}

# ---- zoxide ----
function install_zoxide() {
    brew install zoxide

    echo "source \"\$SHARED_CONF/zshconfig/zoxide_config.zsh\"" >> ./.zshrc 
}

# ---- neovim ----
function install_neovim() {
    sudo apt install -y neovim
    sudo chmod -R 777 /usr/share/config/.config
}

# ---- wsl ----
function install_on_wsl() {
    sudo chmod +777 /etc/wsl.conf
    sudo cat ./wsl.conf > /etc/wsl.conf
}

# ---- dotnet ----
function install_dotnet() {
    wget https://dot.net/v1/dotnet-install.sh -O ./temp/dotnet-install.sh
    sudo chmod +x ./temp/dotnet-install.sh
    sudo ./temp/dotnet-install.sh --version latest --install-dir /usr/share/dotnet > /dev/null
    echo "source \"\$SHARED_CONF/zshconfig/dotnet_config.zsh\"" >> ./.zshrc
}

# ---- node ----
function install_node() {
    brew install nvm
    nvm install --lts
    echo "source \"\$SHARED_CONF/zshconfig/node_config.zsh\"" >> ./.zshrc
}

# ---- glow ----
function install_glow() {
    brew install glow
}

# ---- docker ----
function install_docker() {
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "source \"\$SHARED_CONF/zshconfig/docker_config.zsh\"" >> ./.zshrc
}

# ---- custom aliases ----
function add_custom_aliases() {
    echo "source \"\$SHARED_CONF/zshconfig/custom_aliases.zsh\"" >> ./.zshrc
}

# ---- add wincopy ----
function add_wincopy() {
    echo "source \"\$SHARED_CONF/zshconfig/wincopy_config.zsh\"" >> ./.zshrc
}
