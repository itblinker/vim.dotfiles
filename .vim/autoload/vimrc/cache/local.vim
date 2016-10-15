"{{{
let s:parentPath = getcwd()
let s:dirName = '.vim.cache.local'
let s:cache = s:parentPath.'/'.s:dirName


function! s:createCache() abort
    mkdir(s:dirName, s:parentPath)
endfunction
"}}}

function! vimrc#cache#local#getDirName()
    return s:dirName
endfunction


function! vimrc#cache#local#getPath() abort
    return s:cache
endfunction


function! vimrc#cache#local#isAvailable() abort
    return isdirectory(s:cache)
endfunction


function! vimrc#cache#local#fetch() abort
    if !vimrc#cache#local#isAvailable()
        call s:createCache()
    endif

    return vimrc#cache#local#getPath()
endfunction
