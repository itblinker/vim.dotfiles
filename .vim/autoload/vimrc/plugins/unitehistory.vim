function! vimrc#plugins#unitehistory#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()

    echomsg 'mapcheck is istory unite before: '.mapcheck(',c')

    nnoremap <leader>c :Unite history/command<CR>
endfunction
