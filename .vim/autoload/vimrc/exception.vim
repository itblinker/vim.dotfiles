"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! vimrc#exception#throw(string)
   throw 'vimrc: '.a:string
endfunction


function! s:exception()
    return '[exception] '.v:exception.' [throwpoint]: '.v:throwpoint
endfunction


function! vimrc#exception#warning()
    call vimrc#message#instance().warning(s:exception())
endfunction


function! vimrc#exception#error()
    call vimrc#message#instance().error(s:exception())
endfunction

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
