"{{{ global variables
let g:vimrc#bin#tmux#path = ''
"}}}
"{{{ local functions
function! s:isWorkingUnderTmux() abort
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

function! vimrc#bin#tmux#getPath() abort
    if strlen(g:vimrc#bin#tmux#path)
        return g:vimrc#bin#tmux#path
    elseif executable('tmux')
        return exepath('tmux')
    else
        call vimrc#exceptions#throw('tmux bin not available')
    endif
endfunction


function! vimrc#bin#tmux#isAvailable() abort
    return strlen(g:vimrc#bin#tmux#path) || executable('tmux')
endfunction


function! vimrc#bin#tmux#isWorkingUnder()
    try
        return s:isWorkingUnderTmux()
    catch
        call vimrc#exceptions#echomsg('problem: vimrc#bin#tmux#isWorkingUnder()')
    endtry
endfunction
