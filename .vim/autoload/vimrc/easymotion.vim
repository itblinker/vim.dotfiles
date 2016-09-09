function! vimrc#easymotion#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
    map <leader>f <Plug>(easymotion-f)
    map <leader>F <Plug>(easymotion-F)
    map <leader>j <Plug>(easymotion-j)
    map <leader>k <Plug>(easymotion-k)
endfunction
