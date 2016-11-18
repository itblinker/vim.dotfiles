let g:vimrc#bin#gtags#path = ''

function! vimrc#bin#gtags#isAvailable() abort
    return strlen(g:vimrc#bin#gtags#path) || executable('gtags')
endfunction


function! vimrc#bin#gtags#getPath()
    if strlen(g:vimrc#bin#gtags#path)
        return g:vimrc#bin#gtags#path
    elseif executable('gtags')
        return exepath('gtags')
    else
        call vimrc#exception#throw('gtags bin not available')
    endif
endfunction
