" http://howivim.com/2016/damian-conway/

nmap <silent> <BS> :nohlsearch<CR>

set autowrite
if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.vimundo
    set undofile
endif

"====[ Make the 81st column stand out ]====================
" https://github.com/ninrod/damian_conway_oscon_2013_tarball/tree/2c22b94f35348b2cf56337cecd412e6f701fa2db#damian-conways-more-instantly-better-vim-oscon-2013-talk
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
