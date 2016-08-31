function! vimrc#getLocalCacheDir()
"{{{
    return s:getLocalCacheByCreationIfNeeded()
endfunction

let s:localCacheDirName = '.cache.vim'
let s:localCacheParentDir = getcwd()
let s:localCacheDir = s:localCacheParentDir.'/'.s:localCacheDirName

function! s:getLocalCacheByCreationIfNeeded()
    if !isdirectory(s:localCacheDir)
       call mkdir(s:localCacheDirName, s:localCacheParentDir)
    endif

    return s:localCacheDir
endfunction
"}}}



