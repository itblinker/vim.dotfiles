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
    command! -buffer -nargs=0 GtagsRetag            : call s:instance().tag()
    command! -buffer -nargs=0 GtagsIngoreExcludes
                              \ : call s:instance().ignoreExcludes()  | GtagsRetag
    command! -buffer -nargs=0 GtagsConsiderExcludes
                              \ : call s:instance().considerExcludes() | GtagsRetag
endfunction


function! GtagsCppCIndexer()
    call s:buffersCommand()
    call s:instance().autocmd_filetype()
endfunction


function! s:aucmds()
    augroup vimrGtagsUpdateSingleFile
    au!
    exec 'au BufWritePost'
         \.' '.vimrc#cpp#manager#instance().aucmdsFormat()
         \.' call s:instance().autocmd_bufwritepost(expand(''<afile>''))'
    augroup END
endfunction


call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'GtagsCppCIndexer')
call s:aucmds()

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
