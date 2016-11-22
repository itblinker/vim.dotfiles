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
        return join(map(a:names, 'self.excludeName(v:val)'), ' -o ')
    endfunction


    function! l:obj.names(names)
        if type(a:names) == type('')
            return '-type f -name '''.a:names.''''
        else
            return '-type f \( '.self.formatter.names(self.makeList(a:names)).' \)'
        endif
    endfunction


    function! l:obj.paths(paths)
        if type(a:paths) == type('')
            return a:paths
        endif
    endfunction

    function! l:obj.getCmd(paths, names)
        return 'find '
                    \.self.paths(a:paths).' '
                    \.self.names(a:names)
    endfunction

    return l:obj
endfunction


"--------
" tests
"--------

echomsg 'cmd1: '.s:findFactory().getCmd('./', 'name')
execute 'Dispatch '.s:findFactory().getCmd('./', ['cach*vim', 'find.vim'])

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
