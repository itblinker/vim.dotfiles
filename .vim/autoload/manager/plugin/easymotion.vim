function s:mappings()
    map <leader>f <Plug>(easymotion-f)
    map <leader>F <Plug>(easymotion-F)
    map <leader>j <Plug>(easymotion-j)
    map <leader>k <Plug>(easymotion-k)
endfunction

function manager#plugin#easymotion#Setup()
    call s:mappings()
endfunction


