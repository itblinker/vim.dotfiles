function! vimrc#find#file(filename, path)
    try
        return vimrc#find#file#getList(a:filename, a:path)
    catch
        call vimrc#exceptions#echomsg('vimrc#find#file error')
    endtry
endfunction


function! vimrc#find#isFileExist(filename, path)
    try
        return vimrc#find#file#isReachable(a:filename, a:path)
    catch
        call vimrc#exceptions#echomsg('vimrc#find#file error')
    endtry
endfunction

