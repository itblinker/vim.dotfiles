let s:sourceAndHeaderExtensionMap = {
            \ 'cpp' : 'hpp',
            \ 'hpp' : 'cpp',
            \ 'c'   : 'h',
            \ 'h'   : 'c'
            \ }

function! vimrc#language#cpp#getSourceOrHeaderFilename()
    let l:filenameBase = expand('%:t:r')
    let l:extension = expand('%:e')

    if has_key(s:sourceAndHeaderExtensionMap, l:extension)
        return l:filenameBase.'.'.s:sourceAndHeaderExtensionMap[l:extension]
    else
        return l:filenameBase.'.*'
    endif
endfunction
