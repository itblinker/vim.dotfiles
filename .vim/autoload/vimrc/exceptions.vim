function! vimrc#exceptions#throw(string)
   throw 'vimrc: '.a:string
endfunction


function! vimrc#exceptions#echomsg()
    echomsg '[exception] '.v:exception.' [throwpoint]: '.v:throwpoint
endfunction
