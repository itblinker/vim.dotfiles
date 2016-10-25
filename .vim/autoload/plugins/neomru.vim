function! plugins#neomru#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:neomru#file_mru_path = vimrc#cache#fetch().'/neomru.txt'
endfunction


function! s:mappings()
    noremap <leader>sm :Unite -buffer-name=file_mru file_mru<CR>
endfunction
