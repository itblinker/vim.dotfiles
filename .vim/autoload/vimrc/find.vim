function! vimrc#find#file(filename, path)
    try
        return vimrc#find#file#getList(a:filename, a:path)
    catch
        call vimrc#exception#warning()
    endtry
endfunction


function! vimrc#find#isFileExist(filename, path)
    try
        return vimrc#find#file#isReachable(a:filename, a:path)
    catch
        call vimrc#exception#warning()
    endtry
endfunction

