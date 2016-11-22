"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:findFactory()
    let l:obj = { 'formatter' : {} }


    function! l:obj.formatter.name(name)
        if a:name.casesensitive
            return '-name '''.a:name.name.''''
        else
            return '-iname '''.a:name.name.''''
        endif
    endfunction


    function! l:obj.makeNameList(item)
        let l:item = deepcopy(a:item)

        if type(l:item) == type('')
            let l:item = [ {'name' : a:item, 'casesensitive' : 1} ]
        elseif type(l:item) == type({})
            return [l:item]
        elseif type(l:item) != type([])
            call vimrc#exception#throw('Arg type is not a list')
        endif

        return l:item
    endfunction


    function! l:obj.names(names)
        return '-type f \( '
               \.join(map(self.makeNameList(a:names), 'self.formatter.name(v:val)'), ' -o ')
               \.' \)'
    endfunction


    function! l:obj.formatter.pathExcludeWholeDir(path)
        if ! empty(globpath(getcwd(), a:path))
            return a:path
        else
            call vimrc#exception#throw('exclude dir its not the part of root tree')
        endif
    endfunction


    function! l:obj.formatter.path(path)
        return '-not \( -path '''.self.pathExcludeWholeDir(a:path).''' -prune \)'
    endfunction


    function! l:obj.formatter.paths(pathsList)
        return join(map(a:pathsList, 'self.path(v:val)'), ' ')
    endfunction


    function! l:obj.makePathsList(paths)
        let l:item = deepcopy(a:paths)

        if type(l:item) == type([])
            return l:item
        elseif type(l:item) == type('')
            return [l:item]
        else
            call vimrc#exception#throw('arg type its not a list')
        endif
    endfunction


    function! l:obj.paths(paths)
        if type(a:paths) == type('')
            return a:paths
        else
            try
                return a:paths.include.' '.self.formatter.paths(self.makePathsList(a:paths.exclude))
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

"let s:cmd = s:findFactory().getCmd(['cac*vim', 'auto*.vim'], {'include' : './', 'exclude' : ['./.vim/plugin', './.vim/ftplugin']} )

"let s:cmd = s:findFactory().getCmd('cac*vim', {'include' : './', 'exclude' : ['./.vim/plugin', './.vim/ftplugin']} )
"let s:cmd = s:findFactory().getCmd([
            "\ {'name' : 'cac*vim',   'casesensitive' : 1},
            "\ {'name' : 'auto*.vim', 'casesensitive' : 0}],
            "\ {'include' : './', 'exclude' : ['./.vim/plugin', './.vim/ftplugin']} )

let s:cmd = s:findFactory().getCmd({'name' : 'cac*vim', 'casesensitive' : 1},
                                 \ {'include' : './', 'exclude' : ['./.vim/plugin', './.vim/ftplugin']} )


echomsg 'cmd is '.s:cmd
silent execute 'Dispatch '.s:cmd

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
