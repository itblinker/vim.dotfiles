function! plugins#neoyank#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:neoyank#file = vimrc#cache#fetch().'/neoyank.txt'
endfunction


function! s:mappings()
   nnoremap <leader>y :Unite -buffer-name=history_yank history/yank<CR>
endfunction
