# ---- custom aliases ----
alias clr="clear"
alias cat="bat"
alias vim="nvim"
alias nano="nvim"
alias winclip="$SHARED_CONF/bin/clip.exe"
alias re-source="source $SHARED_CONF/.zshrc"
alias tree="ls --tree"
alias nvimkeybind="zsh $SHARED_CONF/scripts/nvim_keybind.sh"

function refreshssh(){
    eval $(ssh-agent -s) > /dev/null

    # Loop through each private key file in the .ssh directory
    for key in ~/.ssh/*; do
        # Check if the file is a private key (exclude known public key and config files)
        if [[ -f "$key" && "$key" != *.pub && "$key" != *config && "$key" != *known_hosts && $(file -b --mime-type "$key") == "application/octet-stream" ]]; then
            ssh-add "$key" 2>/dev/null        
        fi
    done
}
