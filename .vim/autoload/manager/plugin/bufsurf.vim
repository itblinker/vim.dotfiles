function s:mappings()
    nnoremap <leader>< :BufSurfBack<CR>
    nnoremap <leader>> :BufSurfForward<CR>
endfunction


function manager#plugin#bufsurf#Setup()
    call s:mappings()
endfunction
