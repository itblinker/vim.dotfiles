"{{{
let s:parentPath = expand('$HOME')
let s:dirName = '.vim.cache.global'
let s:cache = s:parentPath.'/'.s:dirName


function! s:createCache() abort
    mkdir(s:dirName, s:parentPath)
endfunction
"}}}

function! vimrc#cache#global#getDirName()
    return s:dirName
endfunction


function! vimrc#cache#global#isAvailable() abort
    return isdirectory(s:cache)
endfunction


function! vimrc#cache#global#getPath() abort
    return s:cache
endfunction


function! vimrc#cache#global#fetch() abort
    if !vimrc#cache#global#isAvailable()
        call s:createCache()
    endif

    return vimrc#cache#global#getPath()
endfunction


