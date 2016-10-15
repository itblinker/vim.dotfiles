function! plugins#neoyank#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:neoyank#file = vimrc#cache#get().'/neoyank.txt'
endfunction


function! s:mappings()
   nnoremap <leader>y :Unite history/yank<CR>
endfunction
