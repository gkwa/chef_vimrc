" https://github.com/junegunn/fzf.vim
" https://www.reddit.com/r/vim/comments/3l7737/fzf_command_reverseisearch/

" regular search
nnoremap <silent> <C-p> :FZF<CR>

" Open buffers
nnoremap <leader>b :Buffers<CR>

" MRU
nnoremap <leader>m :History<CR>

" Command history
command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

" Search history
command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>

" Commands
nnoremap <leader>c :Commands<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
" CTRL-k and CTRL-j will be automatically bound to up and down
let g:fzf_history_dir = '~/.local/share/fzf-history'
