function! vimrc#bufsurf#PostSourceSetup()
    call s:mappings()
endfunction

function! s:mappings()
    nnoremap <leader>< :BufSurfBack<CR>
    nnoremap <leader>> :BufSurfForward<CR>
endfunction

