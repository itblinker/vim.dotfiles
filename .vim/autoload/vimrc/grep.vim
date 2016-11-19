"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:grepFactory()
    let l:obj = {}

    function! l:obj.cmd(string)
        return 'grep! -I -r '.a:string.' --exclude-dir='.vimrc#ignore#instance().grep.get()
    endfunction

    function! l:obj.matchInfo()
        echo 'number of matches: '.len(getqflist())
    endfunction

    function! l:obj.execute(...)
        execute 'silent! '.self.cmd(join(a:000)) | redraw!
        call self.matchInfo()
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
