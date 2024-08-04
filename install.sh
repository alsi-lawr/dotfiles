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
main() {
    init_dir

    gum spin --spinner dot --title "Installing zsh..." --show-output -- bash -c 'source ./functions.sh && install_zsh'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed zsh ✓"
    gum spin --spinner dot --title "Installing oh-my-zsh..." --show-output -- bash -c 'source ./functions.sh && install_oh_my_zsh'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed oh-my-zsh ✓"
    gum spin --spinner dot --title "Installing oh-my-zsh plugins..." --show-output -- bash -c 'source ./functions.sh && install_ohmyzsh_plugins'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed oh-my-zsh plugins ✓"
    sudo chmod +x ./zshconfig/p10k/p10k_init.zsh
    /bin/zsh ./zshconfig/p10k/p10k_init.zsh
    gum spin --spinner dot --title "Installing fzf..." --show-output -- bash -c 'source ./functions.sh && install_fzf'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed fzf ✓"
    sudo apt install ripgrep
    gum spin --spinner dot --title "Installing bat..." --show-output -- bash -c 'source ./functions.sh && install_bat'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed bat ✓"
    gum spin --spinner dot --title "Installing eza..." --show-output -- bash -c 'source ./functions.sh && install_eza'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed eza ✓"
    gum spin --spinner dot --title "Installing thefuck..." --show-output -- bash -c 'source ./functions.sh && install_thefuck'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed thefuck ✓"
    gum spin --spinner dot --title "Installing zoxide..." --show-output -- bash -c 'source ./functions.sh && install_zoxide'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed zoxide ✓"
    gum spin --spinner dot --title "Installing nvm and node lts..." --show-output -- bash -c 'source ./functions.sh && install_node'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed node ✓"
    gum spin --spinner dot --title "Installing docker..." --show-output -- bash -c 'source ./functions.sh && install_docker'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed docker ✓"
    gum spin --spinner dot --title "Installing git-delta..." --show-output -- bash -c 'source ./functions.sh && install_git_delta'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed git-delta ✓"
    gum spin --spinner dot --title "Installing tldr..." --show-output -- bash -c 'source ./functions.sh && install_tldr'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed tldr ✓"
    gum spin --spinner dot --title "Installing dotnet..." --show-output -- bash -c 'source ./functions.sh && install_dotnet'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed dotnet ✓"
    gum spin --spinner dot --title "Installing glow..." --show-output -- bash -c 'source ./functions.sh && install_glow'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed glow ✓"
    echo "Are you running on wsl?"
    RUNNING_ON_WSL=$(gum choose "Running on wsl ubuntu" "Standalone ubuntu")
    if [[ "$RUNNING_ON_WSL" == *"wsl"* ]]; then
        gum spin --spinner dot --title "Removing windows paths, please restart WSL..." --show-output -- bash -c 'source ./functions.sh && install_on_wsl '
        gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Removed windows paths ✓"
        gum spin --spinner dot --title "Adding the wincopy alias to copy file to windows clipboard..." --show-output -- bash -c 'source ./functions.sh && add_wincopy'
        gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Added wincopy ✓"
    fi
    gum spin --spinner dot --title "Adding custom aliases..." --show-output -- bash -c 'source ./functions.sh && add_custom_aliases'
    gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Added custom aliases ✓"
    echo "Install neovim with custom plugins?"
    INSTALL_NVIM=$(gum choose "Yes" "No")

    if [[ "$INSTALL_NVIM" == *"Yes"* ]]; then
        gum spin --spinner dot --title "Installing neovim..." --show-output -- bash -c 'source ./functions.sh && install_neovim'
        gum style --foreground 34 --border rounded --margin "0" --padding "0 1" "Installed neovim ✓"
    fi

    # cleanup
    sudo rm -rf ./temp
}

main
