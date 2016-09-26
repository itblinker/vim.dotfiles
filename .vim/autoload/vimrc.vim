function! vimrc#throw(string) abort
"{{{
   let v:errmsg = 'vimrc: '.a:string
   throw v:errmsg
endfunction
"}}}

function! vimrc#echoExceptionDetails()
"{{{
    echomsg v:errmsg
endfunction
"}}}

function! vimrc#getLocalCacheDirName()
"{{{
    return '.vim.cache.local'
endfunction
"}}}

function! vimrc#getGlobalCacheDirName()
"{{{
    return '.vim.cache.global'
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


let s:localCacheParentDir = getcwd()
let s:localCacheDir = s:localCacheParentDir.'/'.vimrc#getLocalCacheDirName()

let s:globalCacheParentDir = expand('$HOME')
let s:globalCacheDir = s:globalCacheParentDir.'/'.vimrc#getGlobalCacheDirName()

function! s:isLocalCacheAvailable() abort
    return isdirectory(s:localCacheDir)
endfunction

function! s:createLocalCacheDir() abort
    call mkdir(vimrc#getLocalCacheDirName(), s:localCacheParentDir)
endfunction

function! s:isGlobalCacheAvailable() abort
    return isdirectory(s:globalCacheDir)
endfunction

function! s:createGlobalCacheDir() abort
    call mkdir(vimrc#getGlobalCacheDirName(), s:globalCacheParentDir)
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

function! vimrc#getStringVisuallySelected()
"{{{
    "try
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        let lines = getline(lnum1, lnum2)
        let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][col1 - 1:]

        return join(lines, "\n")

    "catch
        "call vimrc#throw('problem with visual selection')
    "endtry
endfunction
"}}}

function! vimrc#isGtagsAvailable()
"{{{
    return executable('gtags')
endfunction
"}}}

function! vimrc#isCMakeListFileAvailable()
"{{{
   return filereadable(getcwd().'/CMakeLists.txt')
endfunction
"}}}

function! vimrc#isYcmProjectConfigFileAvailable()
"{{{
   return filereadable(getcwd().'/.ycm_extra_conf.py')
endfunction
"}}}

function! vimrc#openOlderLlorQfList()
"{{{
    if s:isThisLocationListBuffer()
        lolder
    else
        colder
    endif
endfunction
"}}}

function! vimrc#openNewerLlOrQfList()
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

function! vimrc#escape(string)
"{{{
    return escape(a:string, "*?[{`$\\%#'\"|!<")
endfunction
"}}}

function! vimrc#isSvnRepository()
"{{{
   return isdirectory(getcwd().'/.svn')
endfunction
"}}}
"
function! vimrc#isGitRepository()
"{{{
   return isdirectory(getcwd().'/.git')
endfunction
"}}}
