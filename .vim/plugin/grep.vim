"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

command! -complete=dir -nargs=+ GRep : call vimrc#grep#instance().execute(<f-args>)

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
