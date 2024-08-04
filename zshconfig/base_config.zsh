export SHARED_CONF="/usr/share/config"
export ZSH_DISABLE_COMPFIX=true
export XDG_CONFIG_HOME="/usr/share/config/.config"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$SHARED_CONF/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$SHARED_CONF/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$SHARED_CONF/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  git-auto-fetch
  git-flow
  git-lfs
  gitfast
  gitignore
  nvm
  zsh-syntax-highlighting
  zsh-autosuggestions
  you-should-use
  docker
  docker-compose
  dotnet
)

source $ZSH/oh-my-zsh.sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ---- git ----
export GIT_CONFIG_SYSTEM=$SHARED_CONF/gitconfig
