function! vimrc#plugins#tabpagebuffer#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
    nnoremap <leader>bt  :Unite buffer_tab:-<CR>
endfunction
