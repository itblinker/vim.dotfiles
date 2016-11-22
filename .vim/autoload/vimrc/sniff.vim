"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:findFactory()
    let l:obj = { 'formatter' : {} }


    function! l:obj.makeList(item)
        let l:item = deepcopy(a:item)

        if type(l:item) == type('')
            let l:item = [l:item]
        endif

        if len(l:item) == 0
            call vimrc#exception#throw('name list cannot be empty')
        endif

        return l:item
    endfunction


    function! l:obj.formatter.excludeName(name)
        return '-name '''.a:name.''''
    endfunction


    function! l:obj.formatter.names(names)
        return join(map(a:names, 'self.excludeName(v:val)'), ' ')
    endfunction


    function! l:obj.names(names)
        if type(a:names) == type('')
            return '-type f -name '''.a:names.''''
        else
            return '-type f \( '.self.formatter.names(self.makeList(a:names)).' \)'
        endif
    endfunction

    function! l:obj.getCmd(names)
        return 'find '
                    \.self.names(a:names)
    endfunction

    return l:obj
endfunction


"--------
" tests
"--------

echomsg 'cmd1: '.s:findFactory().getCmd('name')
echomsg 'cmd2: '.s:findFactory().getCmd(['first', 'second'])

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
