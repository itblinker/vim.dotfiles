"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

command! -complete=dir -complete=file -nargs=+ GRep : call vimrc#grep#instance().vimExecution(<f-args>)

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
