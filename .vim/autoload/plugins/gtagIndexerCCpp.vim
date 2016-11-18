"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
""----------------------------------

function! s:defaultCofig()
	let l:obj = { 'dbpath' : {},
				\ 'pathList' : {},
				\ 'filetypes' : {},
				\}

	function l:obj.dbpath.get()
		return getcwd()
	endfunction

	function l:obj.pathList.include()
		return [ getcwd() ]
	endfunction

	function l:obj.pathList.exclude()
		return [ '*test_module*' ]
	endfunction

	function l:obj.filetypes.list()
		return ['*.cpp', '*.hpp','*.c', '*.h', '*.cc', '*.hh', '*.cxx', '*.hxx']
	endfunction

	return l:obj
endfunction


let s:indexerLazyInstance = {}
function! s:instance()
    if empty(s:indexerLazyInstance)
        let s:indexerLazyInstance = gtags#indexer#ccpp#new(s:defaultCofig())
    endif
    return s:indexerLazyInstance
endfunction


function! GtagsIndexerCCppBufferCommands()
    command! -buffer -nargs=0 GtagsRetag           : call s:instance().tag()
    command! -buffer -nargs=0 GtagsExcludesTurnOn  : call s:instance().exclude.turnOn()
    command! -buffer -nargs=0 GtagsExcludesTurnOff : call s:instance().exclude.turnOff()
endfunction


function! plugins#gtagIndexerCCpp#PostSourceSetup()
	call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'GtagsIndexerCCppBufferCommands')

    call s:instance().startup()
endfunction


"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
""---------------------------------------
