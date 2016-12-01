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
                    \ 'files' : '["*.cpp", "*.hpp", "*.c", "*.h", "*.cc", "*.hh", "*.cxx", "*.hxx"]' }
                \}
    "
    " API
    "
    function! l:obj.filenameGlobs()
        return self.globs.files
    endfunction

    return l:obj
endfunction


"
" TEST
"
"let s:manager = vimrc#cpp#manager#instance()
"echomsg 'filenames is: '.string(s:manager.filenameGlobs())

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
