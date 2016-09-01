function! vimrc#throw(string) abort
"{{{
   let v:errmsg = 'vimrc: '.a:string
   throw v:errmsg
endfunction
"}}}

function! vimrc#getCacheDir() abort
"{{{
    try
        return s:fetchLocalCacheDir()
    catch
        try
            return s:fetchGlobalCacheDir()
        catch
            call vimrc#throw('create '.s:globalCacheDir.' manually to suppress the error')
        endtry
    endtry
endfunction


let s:localCacheDirName = '.vim.cache.local'
let s:localParentDir = getcwd()
let s:localCacheDir = s:localParentDir.'/'.s:localCacheDirName

let s:globalCacheDirName = '.vim.cache.global'
let s:globalParentDir = expand('$HOME')
let s:globalCacheDir = s:globalParentDir.'/'.s:globalCacheDirName

function! s:isLocalCacheAvailable() abort
    return isdirectory(s:localCacheDir)
endfunction

function! s:createLocalCacheDir() abort
    call mkdir(s:localCacheDirName, s:localParentDir)
endfunction

function! s:isGlobalCacheAvailable() abort
    return isdirectory(s:globalCacheDir)
endfunction

function! s:createGlobalCacheDir() abort
    call mkdir(s:globalCacheDirName, s:globalParentDir)
endfunction


function! s:fetchLocalCacheDir() abort
    if s:isLocalCacheAvailable()
        return s:localCacheDir
    endif

       call s:createLocalCacheDir()
       return s:localCacheDir
endfunction


function! s:fetchGlobalCacheDir() abort
    if s:isGlobalCacheAvailable()
        return s:globalCacheDir
    endif

       call s:createGlobalCacheDir()
       return s:globalCacheDir
endfunction

function! CreateGlobalDir()
    call s:createGlobalCacheDir()
endfunction

"}}}


