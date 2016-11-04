function! plugins#tabpagebuffer#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
    nnoremap <leader>bb  :Unite -buffer-name=tabs_buffers buffer_tab:-<CR>
endfunction
