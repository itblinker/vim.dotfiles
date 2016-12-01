"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:instance()
    if !exists('s:indexer')
        let s:indexer = vimrc#gtags#cpp#indexer#new(vimrc#gtags#cpp#config#factory())
    endif

    return s:indexer
endfunction


function! s:buffersCommand()
    command! -buffer -nargs=0 GtagsRetag  : call s:instance().tag()
endfunction


function! GtagsCppCIndexerCommands()
    call s:buffersCommand()
endfunction


call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'GtagsCppCIndexerCommands')

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
