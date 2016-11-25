"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:grepFactory()
    let l:obj = {}

    "
    " API
    "
    function! l:obj.composeArgs(arguments)
        return '-I -Hr '.a:arguments.' '.vimrc#ignore#instance().grepFormat()
    endfunction


    function l:obj.vimExecution(...)
        if empty(filter(deepcopy(a:000), 'isdirectory(v:val) || filereadable(v:val)'))
            call vimrc#message#instance().warning("grep: lack of path/file in cmd")
            return
        endif

        execute 'silent! grep! '.self.composeArgs(join(a:000, ' ')) | redraw!
        echo 'grep: number of matches: '.len(getqflist())
    endfunction

    return l:obj
endfunction


let s:grepLazyInstance = {}
function! vimrc#grep#instance()
    if empty(s:grepLazyInstance)
        let s:grepLazyInstance = s:grepFactory()
    endif

    return s:grepLazyInstance
endfunction

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
