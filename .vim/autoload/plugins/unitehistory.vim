function! plugins#unitehistory#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
    nnoremap <leader>c :Unite history/command<CR>
    nnoremap <leader>/ :Unite history/search<CR>
endfunction
