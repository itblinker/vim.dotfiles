"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
""----------------------------------

function! GtagsIndexerCCppBufferCommands()
    command! -buffer -nargs=0 GtagsRetag : call gtag#indexer#ccpp#instance().tag()
    command! -buffer -nargs=0 GtagsExcludesTurnOn : call gtag#indexer#ccpp#instance().exclude.turnOn()
    command! -buffer -nargs=0 GtagsExcludesTurnOff : call gtag#indexer#ccpp#instance().exclude.turnOff()
endfunction


function! plugins#gtagIndexerCCpp#PostSourceSetup()
	call vimrc#utils#autocmd#filetype(['cpp', 'c'], 'GtagsIndexerCCppBufferCommands')

	call gtag#indexer#ccpp#configure(s:configurationFactory())
    call gtag#indexer#ccpp#instance().startup()
endfunction


function! s:configurationFactory()
    let l:obj = gtag#indexer#ccpp#defaultConfiguration#factory()

    unlet l:obj.pathList.exclude
    function! l:obj.pathList.exclude()
        return [ '*test_module*' ]
    endfunction

    unlet l:obj.dbpath.get
    function! l:obj.dbpath.get()
        return vimrc#cache#fetch().'/gtags/cpp'
    endfunction

    return l:obj
endfunction

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
""---------------------------------------
