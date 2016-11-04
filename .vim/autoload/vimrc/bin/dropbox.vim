
let g:vimrc#bin#dropbox#directory = expand('$HOME').'/cloudDisc/Dropbox'
let g:vimrc#bin#dropbox#binPath = ''


function! vimrc#bin#dropbox#isAvailable()
    return strlen(g:vimrc#bin#dropbox#binPath) || executable('dropbox')
endfunction


function! vimrc#bin#dropbox#getPath()
    if strlen(g:vimrc#bin#dropbox#binPath)
        return g:vimrc#bin#dropbox#binPath
    elseif executable('dropbox')
        return exepath('dropbox')
    else
        call vimrc#exceptions#throw('dropbox bin not available')
    endif
endfunction


function! vimrc#bin#dropbox#isDirectoryAvailable()
    return isdirectory(g:vimrc#bin#dropbox#directory)
endfunction


function! vimrc#bin#dropbox#getDirectory() abort
    if !vimrc#bin#dropbox#isAvailable()
        echomsg 'dropbox bin is not available'
    endif

    if !vimrc#bin#dropbox#isDirectoryAvailable()
        call vimrc#exceptions#throw('dropbox folder: '.g:vimrc#bin#dropbox#directory.' is not available')
    endif

    return g:vimrc#bin#dropbox#directory
endfunction
