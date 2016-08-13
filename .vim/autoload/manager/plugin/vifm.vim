function s:mappings()
    execute 'nnoremap <leader>V :execute ''EditVifm ''.expand("%:p:h").'' ''.getcwd()<CR>'
endfunction


function manager#plugin#vifm#Setup()
    call s:mappings()
endfunction
