"{{{
function! s:setAugroupForFiletype(augroup, supportedFiletypesList, funcref) abort
    exec 'augroup '.a:augroup
    exec 'au!'
    exec 'au FileType '.join(a:supportedFiletypesList, ',').' call '.a:funcref.'()'
    exec 'augroup END'
endfunction
"}}}

function! vimrc#utils#plugins#isSupportedFilete(listOfFiletypes)
    try
        return count(a:listOfFiletypes, &filetype)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction


function! vimrc#utils#plugins#setAuCmd(augroupName, supportedFiletypesList, funcref)
    try
        call s:setAugroupForFiletype(a:augroupName, a:supportedFiletypesList, a:funcref)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction

