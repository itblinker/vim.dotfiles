function! vimrc#getStringVisuallySelected()
"{{{
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]

    return join(lines, "\n")
endfunction
"}}}

function! vimrc#isGtagsAvailable()
"{{{
    return executable('gtags')
endfunction
"}}}

function! vimrc#isWorkingUnderTmux()
"{{{
    let session = get(g:, 'tmux_session', '')

    if empty($TMUX) && empty(''.session) || !executable('tmux')
        return 0
    endif

    if !empty(system('tmux has-session -t '.shellescape(session))[0:-2])
        return 0
    else
        return 1
    endif
endfunction
"}}}

function! vimrc#isCMakeListFileAvailable()
"{{{
   return filereadable(getcwd().'/CMakeLists.txt')
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

function! vimrc#isDropboxAvailable()
"{{{

    return isdirectory(s:dropbox_path)
endfunction

let s:dropbox_path = expand('$HOME').'/cloudDisc/Dropbox/notes.vimwiki'
"}}}

function! vimrc#getDropboxDirPath()
"{{{
    return s:dropbox_path
endfunction
"}}}
