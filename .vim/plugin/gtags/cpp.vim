"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

let s:indexer = {}

function! s:instance()
    if empty(s:indexer)
        let s:indexer = vimrc#gtags#cpp#indexer#new(vimrc#gtags#cpp#config#factory())
    endif

    return s:indexer
endfunction


function! s:buffersCommand()
    command! -buffer -nargs=0 GtagsRetag  : call s:instance().tag()
endfunction


function! GtagsCppCIndexer()
    call s:buffersCommand()
    call s:instance().filetype_autocmd()
endfunction


call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'GtagsCppCIndexer')

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
