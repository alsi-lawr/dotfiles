#!/bin/zsh
export SHARED_CONF="/usr/share/config"
source $ZSH/oh-my-zsh.sh
if [[ -r "${XDG_CACHE_HOME:-$SHARED_CONF/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$SHARED_CONF/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source $ZSH/oh-my-zsh.sh
 
USE_DEFAULT_P10K=$(gum choose "Use default powerlevel10k config" "Configure it myself")
if [[ "$USE_DEFAULT_P10K" == *"myself"* ]]; then
    p10k configure
else
    echo "source \"\$SHARED_CONF/zshconfig/p10k/default_p10k.zsh\"" >> $SHARED_CONF/.zshrc
fi
