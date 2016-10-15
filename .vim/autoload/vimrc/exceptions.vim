function! vimrc#exceptions#throw(string)
   let v:errmsg = 'vimrc: '.a:string
   throw v:errmsg
endfunction


function! vimrc#exceptions#echomsg()
    echomsg v:errmsg
endfunction
