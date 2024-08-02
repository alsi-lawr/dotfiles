colorscheme tokyonight-moon
let g:vimspector_enable_mappings = 'HUMAN'
let g:airline_powerline_fonts=1
let g:tmuxline_powerline_separators = 0
set number
set relativenumber
set encoding=utf-8
scriptencoding utf-8
let g:airline#extensions#tmuxline#enabled = 0
:set tabstop=4
:set shiftwidth=4
:set expandtab

" Move Swap Directory to something temporary.
set directory^=$HOME/tempswap/

" This directory should exist.
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" ctrl+p when you move to a file this highlights it.
let g:nerdtree_sync_cursorline = 1

" Read gitignore and dont show relevant files in ctrlp.
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:prettier#config#parser = 'babylon'

let g:ale_linters_ignore = {
      \   'typescript': ['tslint'],
      \}
let g:terminal_emulator="xfce4-terminal"

" ---- OmniSharp config ----
let g:OmniSharp_server_use_mono = 0

let g:OmniSharp_log_file = '/usr/share/config/.omnisharp/omnisharp.log'
let g:OmniSharp_loglevel = 'debug'
let g:OmniSharp_server_path = '/usr/share/config/.omnisharp/bin/OmniSharp'

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" ---- NERD Tree ----
" Close Vim if NERDTree is the only window remaining
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeMapActivateNode='v'
