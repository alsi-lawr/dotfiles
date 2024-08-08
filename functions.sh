#!/bin/bash
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
    sudo bash -c "echo \"if [ -f /usr/share/config/.zshrc ]; then\" >> /etc/zsh/zshrc"
    sudo bash -c "echo \"source /usr/share/config/.zshrc\" >> /etc/zsh/zshrc"
    sudo bash -c "echo \"fi\" >> /etc/zsh/zshrc"
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
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/fzf_config.zsh\"" 
}

# ---- bat ----
function install_bat() {
    brew install bat
    sudo mkdir -p /usr/share/config/.config/bat/themes
    sudo curl -o /usr/share/config/.config/bat/themes/tokyonight_night.tmTheme https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
    bat cache --build
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/bat_config.zsh\"" 
}

# ---- git-delta ----
function install_git_delta() {
    brew install git-delta
}

# ---- eza ----
function install_eza() {
    brew install eza

    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/eza_config.zsh\"" 
}

# ---- tldr ----
function install_tldr() {
    brew install tlrc
}

# ---- the fuck ----
function install_thefuck() {
    brew install thefuck

    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/tf_config.zsh\"" 
}

# ---- zoxide ----
function install_zoxide() {
    brew install zoxide

    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/zoxide_config.zsh\"" 
}

# ---- neovim ----
function install_neovim() {
    sudo apt install -y gcc
    sudo apt install -y make
    sudo apt install -y neovim
    sudo chmod -R 777 /usr/share/config/.config
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/nvim_config.zsh\""
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
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/dotnet_config.zsh\""
}

# ---- node ----
function install_node() {
    brew install nvm
    nvm install --lts
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/node_config.zsh\""
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
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/docker_config.zsh\""
}

# ---- custom aliases ----
function add_custom_aliases() {
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/custom_aliases.zsh\""
}

# ---- add wincopy ----
function add_wincopy() {
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/wincopy_config.zsh\""
}

function install_postgres_lsp() {
    echo "not yet"
}

function install_cargo_rust() {
    export CARGO_HOME="/usr/share/config/.cargo"
    export RUSTUP_HOME="/usr/share/config/.rustup"
    curl https://sh.rustup.rs -sSf | sh
    add_to_zshrc "source \"\$SHARED_CONF/zshconfig/cargo_config.zsh\""
}

function add_to_zshrc(){
    local LINE_TO_ADD=$1

    grep -qF -- "$LINE_TO_ADD" "./.zshrc"
    local result=$?

    if [[ $result -ne 0 ]]; then
        echo "$LINE_TO_ADD" >> ./.zshrc
    fi
}
