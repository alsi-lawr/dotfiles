if empty(glob('/usr/share/config/.vim/autoload/plug.vim'))
  silent !curl -fLo /usr/share/config/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:terminal_shell = '/usr/bin/env zsh'
source /usr/share/config/.vim/autoload/plug.vim

call plug#begin('/usr/share/config/.vim/plugged')
Plug 'folke/tokyonight.nvim'
Plug 'preservim/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' , 'branch' : 'release/1.x' }
Plug 'dense-analysis/ale'
"Fuzzy Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'valloric/MatchTagAlways'
Plug 'jiangmiao/auto-pairs'
call plug#end()
