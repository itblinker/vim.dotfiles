"{{{ local function
function! s:escape(string)
    return escape(a:string, "*?[{`$\\%#'\"|!<")
endfunction


function! s:getSelection() abort
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]

    return join(lines, "\n")
endfunction
"}}}

function! vimrc#utils#string#escape(string)
    try
        return s:escape(a:string)
    catch
       call vimrc#exceptions#echomsg('problem: vimrc#utils#string#escape()')
    endtry
endfunction


function! vimrc#utils#string#getSelection()
    try
        return s:getSelection()
    catch
       call vimrc#exceptions#echomsg()
    endtry
endfunction

