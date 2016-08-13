function s:mappings()
    nnoremap <silent> <leader>/ :call NERDComment(0,"toggle")<CR>
    vnoremap <silent> <leader>/ :call NERDComment(0,"toggle")<CR>
endfunction


function manager#plugin#nerdcomment#Setup()
    call s:mappings()
endfunction
