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
    if !s:isLocalCacheAvailable()
        call s:createLocalCacheDir()
    endif

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

function! vimrc#GetStringVisuallySelected()
"{{{
    try
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        let lines = getline(lnum1, lnum2)
        let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][col1 - 1:]

        return join(lines, "\n")

    catch
        call vimrc#throw('problem with visual selection')
    endtry
endfunction
"}}}

function! vimrc#IsGtagsAvailable()
"{{{
    return executable('gtags')
endfunction
"}}}

function! vimrc#IsCMakeListFileAvailable()
"{{{
   return filereadable(getcwd().'/CMakeLists.txt')
endfunction
"}}}

function! vimrc#IsYcmProjectConfigFileAvailable()
"{{{
   return filereadable(getcwd().'/.ycm_extra_conf.py')
endfunction
"}}}

function vimrc#OpenOlderLlorQfList()
"{{{
    if s:isThisLocationListBuffer()
        lolder
    else
        colder
    endif
endfunction
"}}}

function vimrc#OpenNewerLlOrQfList()
"{{{
    if s:isThisLocationListBuffer()
        lnewer
    else
        cnewer
    endif
endfunction


function s:isThisLocationListBuffer()
    let curbufnr = winbufnr(0)
    for bufnum in map(filter(split(s:getBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if curbufnr == bufnum
            return 1
        endif
    endfor
    return 0
endfunction

function s:getBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction
"}}}
