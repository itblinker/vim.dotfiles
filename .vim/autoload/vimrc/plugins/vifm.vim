function! vimrc#plugins#vifm#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
    execute 'nnoremap <leader>V :execute ''EditVifm ''.expand("%:p:h").'' ''.getcwd()<CR>'
endfunction
