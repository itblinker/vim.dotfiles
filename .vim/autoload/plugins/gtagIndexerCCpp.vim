"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
""----------------------------------

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

let s:lazyIndexerInstance = {}

function! s:instance()
    if empty(s:lazyIndexerInstance)
        let s:lazyIndexerInstance = gtag#indexer#ccpp#new(s:configurationFactory())
    endif

    return s:lazyIndexerInstance
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
