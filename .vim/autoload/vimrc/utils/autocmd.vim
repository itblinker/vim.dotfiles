"{{{ local functions
function! s:filetypeAutoCmd(name, supportedFiletypesList, funcref) abort
    exec 'augroup '.a:name
    exec 'au!'
    exec 'au FileType '.join(a:supportedFiletypesList, ',').' call '.a:funcref.'()'
    exec 'augroup END'
endfunction
"}}}

function! vimrc#utils#autocmd#filetype(listOfFiletypes, funcref)
    let l:name = 'augroup_filetypes_'.join(a:listOfFiletypes, '_').'_'.a:funcref
    try
        call s:filetypeAutoCmd(l:name, a:listOfFiletypes, a:funcref)
    catch
       call vimrc#exception#error()
    endtry
endfunction
