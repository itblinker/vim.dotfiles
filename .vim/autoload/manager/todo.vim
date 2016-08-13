function s:isBufferAvailable(p_filename)
    if bufname(a:p_filename) == -1
        return 0
    else
        return 1
    endif
endfunction


function manager#todo#OpenTodo()

endfunction
