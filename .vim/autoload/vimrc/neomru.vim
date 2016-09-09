function! vimrc#neomru#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:neomru#file_mru_path = vimrc#getCacheDir().'/neomru.txt'
endfunction


function! s:mappings()
    noremap <leader>sm :Unite file_mru<CR>
endfunction
