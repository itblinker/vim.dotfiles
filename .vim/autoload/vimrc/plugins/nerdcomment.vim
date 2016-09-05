function! vimrc#plugins#nerdcomment#PreSourceSetup()
    let g:NERDCreateDefaultMappings = 0
endfunction


function! vimrc#plugins#nerdcomment#PostSourceSetup()
    call s:mappings()
endfunction




function! s:mappings()
    nnoremap <silent> <leader>/ :call NERDComment(0,"toggle")<CR>
    vnoremap <silent> <leader>/ :call NERDComment(0,"toggle")<CR>
endfunction
