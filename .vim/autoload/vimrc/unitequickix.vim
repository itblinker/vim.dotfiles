function! vimrc#unitequickix#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
   nnoremap <leader>q :Unite quickfix<CR>
   nnoremap <leader>l :Unite location_list<CR>
endfunction

