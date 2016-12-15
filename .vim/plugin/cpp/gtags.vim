"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:buffersCommand()
    command! -buffer -nargs=0 GtagsRetag            : call vimrc#gtags#cpp#instance().tag()
    command! -buffer -nargs=0 GtagsIngoreExcludes   : call vimrc#gtags#cpp#instance().ignoreExcludes()  | GtagsRetag
    command! -buffer -nargs=0 GtagsConsiderExcludes : call vimrc#gtags#cpp#instance().considerExcludes() | GtagsRetag
endfunction


function! VimrcGtagsCppAuCmdsFiletype()
    call s:buffersCommand()
    call vimrc#gtags#cpp#instance().autocmd_filetype()
endfunction


function! s:aucmds()
    augroup vimrGtagsCppAuCmdsUpdateSingleFile
    au!
    exec 'au BufWritePost'
         \.' '.vimrc#cpp#manager#instance().extensions_format_aucmds()
         \.' call vimrc#gtags#cpp#instance().autocmd_bufwritepost(expand(''<afile>''))'
    augroup END
endfunction


call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'VimrcGtagsCppAuCmdsFiletype')
call s:aucmds()

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
