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

function! s:isThisLocationListBuffer()
    let curbufnr = winbufnr(0)
    for bufnum in map(filter(split(s:getBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if curbufnr == bufnum
            return 1
        endif
    endfor
    return 0
endfunction

function! s:getBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction
"}}}


function! vimrc#isSvnRepository()
"{{{
   return isdirectory(getcwd().'/.svn')
endfunction
"}}}
