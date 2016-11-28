"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:managerFactory()
    let l:obj = {'globs' : {
                    \ 'files' : ['*.cpp', '*.hpp','*.c', '*.h', '*.cc', '*.hh', '*.cxx', '*.hxx'] }
                \}
    "
    " API
    "
    function! l:obj.filenameGlobs()
        return deepcopy(self.globs.files)
    endfunction

    return l:obj
endfunction


let s:managerLazyInstance = {}
function! vimrc#cpp#manager#instance()
    if empty(s:managerLazyInstance)
        let s:managerLazyInstance = s:managerFactory()
    endif

    return s:managerLazyInstance
endfunction

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
