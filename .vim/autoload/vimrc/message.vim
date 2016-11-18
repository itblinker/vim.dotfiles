"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:messageFactory()
    let l:obj = { 'stream' : vital#vimrc#import('Vim.Message') }

    function! l:obj.warning(string)
        call self.stream.warn(a:string)
    endfunction

    function! l:obj.error(string)
        call self.stream.error(a:string)
    endfunction

    return l:obj
endfunction


let s:messageLazyInstance = {}

function! vimrc#message#instance()
    if empty(s:messageLazyInstance)
        let s:messageLazyInstance = s:messageFactory()
    endif

    return s:messageLazyInstance
endfunction

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
