" --- NERD Tree ----
:map <C-n> :NERDTreeToggle<CR>
:map <C-m> :call FocusAndRefreshNERDTree()<CR>

function! FocusAndRefreshNERDTree()
  NERDTreeFocus
  NERDTreeRefreshRoot
endfunction

:map <C-p> :GFiles<CR>
:map <C-f> :Files<CR>
" ---- collapse json files by themselves. ----
:map <C-j> :set filetype=json \| :syntax on \| :set foldmethod=syntax

" ---- Auto indent your file. ----
map <F7> gg=G<C-o><C-o>

" ---- Navigate Tabs ----
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" ---- Toggle relative line number ----
nmap <C-L><C-L> :set norelativenumber<CR>
map  <C-R><C-L> :set relativenumber<CR>

" ---- OmniSharp for .NET ----
autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
autocmd FileType cs nnoremap <M-.> :OmniSharpGetCodeActions<CR>
autocmd FileType cs nnoremap <Leader><Space> :OmniSharpDocumentation<CR>

" ---- QOL ----
noremap <C-q> :q<cr>
noremap <M-s> :wq<cr>
noremap <C-c> :qa!<cr>
noremap <C-s> :w<cr>
noremap <C-k> :vsplit<cr>
noremap <M-t> :term<cr>
