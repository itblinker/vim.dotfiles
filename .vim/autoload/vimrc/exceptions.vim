function! vimrc#exceptions#throw(string)
   let v:errmsg = 'vimrc: '.a:string
   throw v:errmsg
endfunction


function! vimrc#exceptions#echomsg()
    if a:0 == 1
        echomsg a:1.' error msg: '.v:errmsg
    else
        echomsg v:errmsg
    endif
endfunction

