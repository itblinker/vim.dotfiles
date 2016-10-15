function! vimrc#utils#isFiletypeMatch(listOfFiletypes)
    try
        return count(a:listOfFiletypes, &filetype)
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction

