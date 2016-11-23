"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:findFactory()
    let l:obj = { 'formatter' : {} }


    function! l:obj.formatter.name(name)
        if type(a:name) == type('')
            return '-name '''.a:name.''''
        elseif has_key(a:name, 'name')
            return '-name '''.a:name.name.''''
        elseif has_key(a:name, 'iname')
            return '-iname '''.a:name.iname.''''
        endif
    endfunction


    function! l:obj.formatter.makeNameList(item)
        let l:item = deepcopy(a:item)

        if type(l:item) == type('')
            let l:item = [ {'name' : a:item, 'casesensitive' : 1} ]
        elseif type(l:item) == type({})
            return [l:item]
        elseif type(l:item) != type([])
            call vimrc#exception#throw('invalid argument type: '.string(a:item'))
        endif

        return l:item
    endfunction


    function! l:obj.names(names)
        return '-type f \( '
               \.join(map(self.formatter.makeNameList(a:names), 'self.formatter.name(v:val)'), ' -o ')
               \.' \)'
    endfunction


    function! l:obj.formatter.getUniquePathOfRootsChild(path)
        if len(split(globpath(getcwd(), a:path), expand('<NL>'))) == 1
            return a:path
        else
            call vimrc#exception#throw('exclude dir its not the part or is not unique of root tree: '.string(a:path))
        endif
    endfunction


    function! l:obj.formatter.path(path)
        if type(a:path) == type('')
            return '-not \( -path '''.self.getUniquePathOfRootsChild(a:path).''' -prune \)'
        else
            call vimrc#exception#throw('improper arg: '.string(a:path))
        endif
    endfunction


    function! l:obj.formatter.paths(pathsList)
        return join(map(a:pathsList, 'self.path(v:val)'), ' ')
    endfunction


    function! l:obj.formatter.makePathsList(paths)
        let l:items = deepcopy(a:paths)

        if type(l:items) == type([])
            return l:items
        elseif type(l:items) == type('') || type(l:items) == type({})
            return [l:items]
        else
            call vimrc#exception#throw('improper type: arg: '.string(a:path))
        endif
    endfunction


    function! l:obj.path(path)
        if type(a:path) == type('')
            return a:path
        elseif type(a:path) == type({})
            return a:path.path.' '.self.formatter.paths(self.formatter.makePathsList(a:path.exclude))
        else
            call vimrc#exception#throw('invalid argument type: '.string(a:path)')
        endif
    endfunction


    function! l:obj.formatter.makePatternsListForExcludeDirs(patterns)
        if type(a:patterns) == type([])
            return a:patterns
        elseif type(a:patterns) == type('')
            return [a:patterns]
        elseif has_key(a:patterns, 'iname') || has_key(a:patterns, 'name')
            return [a:patterns]
        else
            call vimrc#exception#throw('invalid arg: '.string(a:patterns))
        endif
    endfunction


    function! l:obj.formatter.excludeDirPattern(pattern)
        if type(a:pattern) == type('')
            return '-not \( -type d -name '''.a:pattern.''' -prune \)'
        elseif has_key(a:pattern, 'iname')
            return '-not \( -type d -iname '''.a:pattern.iname.''' -prune \)'
        elseif has_key(a:pattern, 'name')
            return '-not \( -type d -name '''.a:pattern.name.''' -prune \)'
        else
            call vimrc#exception#throw('invalid arg: '.string(a:pattern))
        endif
    endfunction


    function! l:obj.excludeDirPatterns(patterns)
        return join(map(self.formatter.makePatternsListForExcludeDirs(a:patterns), 'self.formatter.excludeDirPattern(v:val)'), ' ')
    endfunction


    function! l:obj.cmdComposer(names, path, excludeDirPatterns)
        return 'find '
                    \.self.path(a:path).' '
                    \.self.excludeDirPatterns(a:excludeDirPatterns).' '
                    \.self.names(a:names)
    endfunction


    function! l:obj.getCmd(names, paths, excludeDirPatterns)
        if type(a:paths) != type([])
            return self.cmdComposer(a:names, a:paths, a:excludeDirPatterns)
        else
            let l:cmdList = []

            for l:path in a:paths
                call add(l:cmdList, self.cmdComposer(a:names, l:path, a:excludeDirPatterns))
            endfor

            return join(l:cmdList, ' && ')
        endif
    endfunction


    return l:obj
endfunction


"--------
" tests
"--------

"let s:cmd = s:findFactory().getCmd(['sniff*', {'name' : 'cac*vim'}, {'iname' : 'auto*.vim'}],
            "\'./'', '')

"let s:cmd = s:findFactory().getCmd(['sniff*', {'iname' : 'cac*vim'}, {'name' : 'auto*.vim'}],
            "\ [{'path' : './', 'exclude' : './.vim/autoload/vital'},
            "\ {'path' : './', 'exclude' : './.vim/autoload/vital'}] , '')

let s:cmd = s:findFactory().getCmd(['sniff*', {'iname' : 'cac*vim'}, {'name' : 'auto*.vim'}],
            \ {'path' : './', 'exclude' : []}, [{'iname' : 'system'}, {'name' : 'dupa'}, 'elo'])


echomsg 'cmd is '.s:cmd
silent execute 'Dispatch '.s:cmd

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
