function! vimrc#throw(string) abort
"{{{
   let v:errmsg = 'vimrc: '.a:string
   throw v:errmsg
endfunction
"}}}

function! vimrc#isCwdWritable() abort
"{{{
    return filewritable(getcwd())
endfunction
"}}}

function! vimrc#getLocalCacheDir() abort
"{{{
    return s:getLocalCacheByCreationIfNeeded()
endfunction

let s:localCacheDirName = '.cache.vim'
let s:localCacheParentDir = getcwd()
let s:localCacheDir = s:localCacheParentDir.'/'.s:localCacheDirName

function! s:getLocalCacheByCreationIfNeeded() abort
    try
        if !isdirectory(s:localCacheDir)
            call mkdir(s:localCacheDirName, s:localCacheParentDir)
        endif
    catch
        call vimrc#throw('cannot create local cache directory')
    endtry

    return s:localCacheDir
endfunction
"}}}


