"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:findFactory()
    let l:obj = { 'formatter' : {} }


    function! l:obj.makeList(item)
        let l:item = deepcopy(a:item)

        if type(l:item) == type('')
            let l:item = [l:item]
        elseif type(l:item) != type([])
            call vimrc#exception#throw('arg type is not a list')
        endif

        return l:item
    endfunction


    function! l:obj.formatter.excludeName(name)
        return '-name '''.a:name.''''
    endfunction


    function! l:obj.formatter.names(names)
        let l:out =  join(map(a:names, 'self.excludeName(v:val)'), ' -o ')

        if strlen(l:out)
            return l:out
        else
            return '-name ''*'''
        endif
    endfunction


    function! l:obj.names(names)
        if type(a:names) == type('')
            if a:names != ''
                return '-type f -name '''.a:names.''''
            else
                return '-type f -name ''*'''
            endif
        else
            return '-type f \( '.self.formatter.names(self.makeList(a:names)).' \)'
        endif
    endfunction


    function! l:obj.formatter.pathExcludeDir(path)
        if ! empty(globpath(getcwd(), a:path))
            return a:path
        else
            call vimrc#exception#throw('exclude dir its not the part of root tree')
        endif
    endfunction


    function! l:obj.formatter.path(path)
        return '-not \( -path '''.self.pathExcludeDir(a:path).''' -prune \)'
    endfunction


    function! l:obj.formatter.paths(pathsList)
        return join(map(a:pathsList, 'self.path(v:val)'), ' ')
    endfunction


    function! l:obj.paths(paths)
        if type(a:paths) == type('')
            return a:paths
        else
            try
                return a:paths.include.' '.self.formatter.paths(self.makeList(a:paths.exclude))
            catch
                call vimrc#exception#throw('path argument, shold be dict with {include,exlucde} keys')
            endtry
        endif
    endfunction

    function! l:obj.getCmd(names, paths)
        return 'find '
                    \.self.paths(a:paths).' '
                    \.self.names(a:names)
    endfunction

    return l:obj
endfunction


"--------
" tests
"--------

let s:cmd = s:findFactory().getCmd('auto*.vim', {'include' : './', 'exclude' : ['./.vim/plugin', './.vim/ftplugin']} )

echomsg 'cmd is '.s:cmd
silent execute 'Dispatch '.s:cmd

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
