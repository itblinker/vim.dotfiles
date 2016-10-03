function plugins#uniteCmdmatch#PostSourceSetup()
    call s:mappings()
endfunction


function s:mappings()
    cmap <silent> <c-o> <Plug>(unite_cmdmatch_complete)
endfunction
