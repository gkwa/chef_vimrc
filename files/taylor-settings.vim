" flash screen instead of sounding a beep
set visualbell

set nostartofline
set tabstop=2
set shiftwidth=2
set expandtab
set nobackup
set noswapfile
set nowrap

" ignore case
set ic

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

set wildmenu
set hidden
set number
syntax on

filetype plugin indent on

" pretty print json
nmap =j :%!python -m json.tool<CR>

nnoremap <silent> <Leader><Leader> :Files <C-R>=expand('%:h')<CR><CR>

" save open buffer list and re-open on next vim run
:exec 'set viminfo=%,' . &viminfo

" https://hashrocket.com/blog/posts/8-great-vim-mappings
set pastetoggle=<leader>z

" show help in single window
nnoremap <leader>ho :h \| only<CR>

" https://stackoverflow.com/a/26431632/1495086
" show help in single window
" use: H: {subject}
command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" set workng directory to directory of current buffer
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
