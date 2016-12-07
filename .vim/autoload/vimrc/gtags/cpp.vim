"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

let s:indexer = {}

function! vimrc#gtags#cpp#instance()
    if empty(s:indexer)
        let s:indexer = vimrc#gtags#cpp#indexer#new(vimrc#gtags#cpp#config#factory())
    endif

    return s:indexer
endfunction


"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
