"{{{
function! s:setAugroupForFiletype(augroup, supportedFiletypesList, funcref) abort
    exec 'augroup '.a:augroup
    exec 'au!'
    exec 'au FileType '.join(a:supportedFiletypesList, ',').' call '.a:funcref.'()'
    exec 'augroup END'
endfunction


function! s:getSelection() abort
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]

    return join(lines, "\n")
endfunction
"}}}

function! vimrc#utils#isSupportedFilete(supportedFiletypesList)
    try
        return count(a:supportedFiletypesList, &filetype)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction


function! vimrc#utils#setAugroupForFiletype(augroupName, supportedFiletypesList, funcref)
    try
        call s:setAugroupForFiletype(a:augroupName, a:supportedFiletypesList, a:funcref)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction


function! vimrc#utils#getSelection()
    try
        return s:getSelection()
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction
