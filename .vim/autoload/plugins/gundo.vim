function! plugins#gundo#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:gundo_width = 60
    let g:gundo_preview_height = 20
endfunction


function! s:mappings()
    nnoremap <silent> <leader>U :GundoShow<CR>
endfunction

