" http://howivim.com/2016/damian-conway/

nmap <silent> <BS>  :nohlsearch<CR>

set autowrite
if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.VIM_UNDO_FILES
    set undofile
endif