"{{{ local functions
function! s:filetypeAutoCmd(name, supportedFiletypesList, funcref) abort
    exec 'augroup '.a:name
    exec 'au!'
    exec 'au FileType '.join(a:supportedFiletypesList, ',').' call '.a:funcref.'()'
    exec 'augroup END'
endfunction
"}}}

function! vimrc#utils#autocmd#filetype(name, listOfFiletypes, funcref)
    try
        call s:filetypeAutoCmd(a:name, a:listOfFiletypes, a:funcref)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction
