function! s:find(filename, path)
    let l:found = systemlist('find '.a:path.' -name '.a:filename)
    call filter(l:found, 'filereadable(v:val)')
    return l:found
endfunction


function! vimrc#find#file#getList(filename, path) abort
    if type(a:path) == type("")
        return s:find(a:filename, a:path)
    elseif type(a:path) == type([])
        return s:find(a:filename, join(a:path, ' '))
    endif

    call vimrc#exceptions#throw(expand('%:p').': incorrect argumnent type')
endfunction


function! vimrc#find#file#isReachable(filename, path)
    return len(vimrc#find#file#getList(a:filename, a:path))
endfunction
