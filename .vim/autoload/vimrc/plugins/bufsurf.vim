function vimrc#plugins#bufsurf#Setup()
    call s:mappings()
endfunction

function s:mappings()
    nnoremap <leader>< :BufSurfBack<CR>
    nnoremap <leader>> :BufSurfForward<CR>
endfunction

