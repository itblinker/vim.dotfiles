"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

"
" API
"
function! vimrc#cpp#manager#instance()
    if empty(s:managerLazyInstance)
        let s:managerLazyInstance = s:managerFactory()
    endif

    return s:managerLazyInstance
endfunction


let s:managerLazyInstance = {}

function! s:managerFactory()
    let l:obj = {'globs' : {
                    \ 'files' : ['*.cpp', '*.hpp', '*.c', '*.h', '*.cc', '*.hh', '*.cxx', '*.hxx'] }
                \}
    call extend(l:obj, {'formatter': {}})

    function! l:obj.formatter.wrap(glob)
        return '"'.a:glob.'"'
    endfunction

    "
    " API
    "
    function! l:obj.tomlConfigFormat()
        return join(map(deepcopy(self.globs.files), 'self.formatter.wrap(v:val)'), ', ')
    endfunction

    function! l:obj.aucmdsFormat()
        return join(deepcopy(self.globs.files), ',')
    endfunction


    return l:obj
endfunction


"
" TEST
"
"let s:manager = vimrc#cpp#manager#instance()
"echomsg 'filenames is: '.string(s:manager.filenameGlobs())
"echomsg 'filenames is: '.s:manager.tomlConfigFormat()

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
