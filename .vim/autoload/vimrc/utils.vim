
"{{{
function! s:isSupportedFiletypes(supportedFiletypesList)
    return count(a:supportedFiletypesList, &filetype)
endfunction
"}}}
function! vimrc#utils#isSupportedFilete(supportedFiletypesList)
"{{{
    try
        return s:isSupportedFiletypes(a:supportedFiletypesList)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction
"}}}

"{{{
function! s:extractSupportedFiltes(supported_filetypes)
    return join(a:supported_filetypes, ',')
endfunction
"}}}
"{{{
function s:setAugroupForFiletype(augroup, supportedFiletypesList, funcref)
    exec 'augroup '.a:augroup
    exec 'au!'
    exec 'au FileType '.s:extractSupportedFiltes(a:supportedFiletypesList).' call '.a:funcref.'()'
    exec 'augroup END'
endfunction

"}}}

function! vimrc#utils#setAugroupForFiletype(augroupName, supportedFiletypesList, funcref)
"{{{
    try
        call s:setAugroupForFiletype(a:augroupName, a:supportedFiletypesList, a:funcref)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction
"}}}

