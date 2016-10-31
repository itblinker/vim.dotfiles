let g:vimrc#bin#git#path = ''

function! vimrc#bin#git#getPath() abort
    if strlen(g:vimrc#bin#git#path)
        return g:vimrc#bin#git#path
    elseif executable('git')
        return exepath('git')
    else
        call vimrc#exceptions#throw('git bin not available')
    endif
endfunction


function! vimrc#bin#git#isCwdRepository()
    return isdirectory(getcwd().'/.git')
endfunction
