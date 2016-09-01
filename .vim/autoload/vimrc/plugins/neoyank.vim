function! vimrc#plugins#neoyank#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:neoyank#file = vimrc#getLocalCacheDir().'/neoyank.txt'
endfunction


function! s:mappings()
   nnoremap <leader>y :Unite history/yank<CR>
endfunction
