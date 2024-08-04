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
    echo "SHARED_CONF=/usr/share/config" > .zshrc
    echo "source \"\$SHARED_CONF/zshconfig/base_config.zsh\"" >> .zshrc

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
main() {
    init_dir

    bash -c 'source ./functions.sh && install_zsh'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed zsh ✓"
    bash -c 'source ./functions.sh && install_oh_my_zsh'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed oh-my-zsh ✓"
    bash -c 'source ./functions.sh && install_ohmyzsh_plugins'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed oh-my-zsh plugins ✓"
    sudo chmod +x ./zshconfig/p10k/p10k_init.zsh
    /bin/zsh ./zshconfig/p10k/p10k_init.zsh
    bash -c 'source ./functions.sh && install_fzf'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed fzf ✓"
    sudo apt install ripgrep
    bash -c 'source ./functions.sh && install_bat'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed bat ✓"
    bash -c 'source ./functions.sh && install_eza'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed eza ✓"
    bash -c 'source ./functions.sh && install_thefuck'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed thefuck ✓"
    bash -c 'source ./functions.sh && install_zoxide'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed zoxide ✓"
    bash -c 'source ./functions.sh && install_node'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed node ✓"
    bash -c 'source ./functions.sh && install_docker'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed docker ✓"
    bash -c 'source ./functions.sh && install_git_delta'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed git-delta ✓"
    bash -c 'source ./functions.sh && install_tldr'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed tldr ✓"
    bash -c 'source ./functions.sh && install_dotnet'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed dotnet ✓"
    bash -c 'source ./functions.sh && install_glow'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed glow ✓"
    echo "Are you running on wsl?"
    RUNNING_ON_WSL=$(gum choose "Running on wsl ubuntu" "Standalone ubuntu")
    if [[ "$RUNNING_ON_WSL" == *"wsl"* ]]; then
        bash -c 'source ./functions.sh && install_on_wsl '
        gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Removed windows paths ✓"
        bash -c 'source ./functions.sh && add_wincopy'
        gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Added wincopy ✓"
    fi
    bash -c 'source ./functions.sh && add_custom_aliases'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Added custom aliases ✓"
    echo "Install neovim with custom plugins?"
    INSTALL_NVIM=$(gum choose "Yes" "No")

    if [[ "$INSTALL_NVIM" == *"Yes"* ]]; then
        bash -c 'source ./functions.sh && install_neovim'
        gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed neovim ✓"
    fi

    # cleanup
    sudo rm -rf ./temp
}

main
