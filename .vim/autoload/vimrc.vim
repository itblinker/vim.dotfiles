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

function! vimrc#getCacheDir() abort
"{{{
    try
        return s:fetchLocalCacheDir()
    catch
        try
            return s:fetchGlobalCacheDir()
        catch
            call vimrc#throw('cannot create cache directory')
        endtry
    endtry
endfunction


let s:cacheDirName = '.cache.vim'

let s:localParentDir = getcwd()
let s:localCacheDir = s:localParentDir.'/'.s:cacheDirName

let s:globalParentDir = expand('$HOME')
let s:globalCacheDir = s:globalParentDir.'/'.s:cacheDirName

function! s:isLocalCacheAvailable() abort
    return isdirectory(s:localCacheDir)
endfunction

function! s:createLocalCacheDir() abort
    call mkdir(s:cacheDirName, s:localParentDir)
endfunction

function! s:isGlobalCacheAvailable() abort
    return isdirectory(s:globalCacheDir)
endfunction

function! s:createGlobalCacheDir() abort
    call mkdir(s:cacheDirName, s:globalParentDir)
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

"}}}


