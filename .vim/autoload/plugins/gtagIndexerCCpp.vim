"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
""----------------------------------

function! GtagsIndexerCCppBufferCommands()
    command! -buffer -nargs=0 GtagsFullTag : call gtag#indexer#ccpp#instance().tag()
endfunction


function! plugins#gtagIndexerCCpp#PostSourceSetup()
	call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'GtagsIndexerCCppBufferCommands')
endfunction


"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
""---------------------------------------
