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
            call vimrc#exception#throw('invalid argument type: '.string(a:item))
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
            call vimrc#exception#throw('improper type: arg: '.string(a:paths))
        endif
    endfunction


    function! l:obj.formatter.rootPath(path)
        if a:path == './'
            return getcwd()
        else
            return a:path
        endif
    endfunction


    function! l:obj.path(path)
        if type(a:path) == type('')
            return self.formatter.rootPath(a:path)
        elseif has_key(a:path, 'path') && (! has_key(a:path, 'exclude'))
            return self.formatter.rootPath(a:path.path)
        elseif has_key(a:path, 'path') && has_key(a:path, 'exclude')
            echomsg 'yes here'
            return self.formatter.rootPath(a:path.path).' '
                   \ .self.formatter.paths(self.formatter.makePathsList(a:path.exclude))
        else
            call vimrc#exception#throw('invalid argument type: '.string(a:path))
        endif
    endfunction


    function! l:obj.formatter.makePatternsListForExcludes(patterns)
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


    function! l:obj.formatter.excludeDirPatterns(pattern)
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


    function! l:obj.formatter.excludeFilePatterns(pattern)
        if type(a:pattern) == type('')
            return '-not \( -type f -name '''.a:pattern.''' -prune \)'
        elseif has_key(a:pattern, 'iname')
            return '-not \( -type f -iname '''.a:pattern.iname.''' -prune \)'
        elseif has_key(a:pattern, 'name')
            return '-not \( -type f -name '''.a:pattern.name.''' -prune \)'
        else
            call vimrc#exception#throw('invalid arg: '.string(a:pattern))
        endif
    endfunction


    function! l:obj.excludeDirPatterns(patterns)
        if len(a:patterns)
            return join(map(self.formatter.makePatternsListForExcludes(a:patterns), 'self.formatter.excludeDirPatterns(v:val)'), ' ')
        else
            return ''
        endif
    endfunction



    function! l:obj.excludeFilePatterns(patterns)
        if len(a:patterns)
            return join(map(self.formatter.makePatternsListForExcludes(a:patterns), 'self.formatter.excludeFilePatterns(v:val)'), ' ')
        else
            return ''
        endif
    endfunction


    function! l:obj.cmdComposer(names, path, excludeDirPatterns, excludeFilePatterns)
        return 'find '
                    \.self.path(a:path).' '
                    \.self.excludeDirPatterns(a:excludeDirPatterns).' '
                    \.self.excludeFilePatterns(a:excludeFilePatterns).' '
                    \.vimrc#ignore#instance().find.format().' '
                    \.self.names(a:names)
    endfunction


    function! l:obj.getCmd(names, paths, excludeDirPatterns, excludeFilePatterns)
        if type(a:paths) != type([])
            return self.cmdComposer(a:names, a:paths, a:excludeDirPatterns, a:excludeFilePatterns)
        else
            let l:cmdList = []

            for l:path in a:paths
                call add(l:cmdList, self.cmdComposer(a:names, l:path, a:excludeDirPatterns, a:excludeFilePatterns))
            endfor

            return join(l:cmdList, ' && ')
        endif
    endfunction


    "------
    " API
    "------
    function! l:obj.cmd(...)
        try
            if a:0 == 1
                return self.getCmd(a:1, './', '', '')
            elseif a:0 == 2
                return self.getCmd(a:1, a:2, '', '')
            elseif a:0 == 3
                return self.getCmd(a:1, a:2, a:3, '')
            elseif a:0 == 4
                return self.getCmd(a:1, a:2, a:3, a:4)
            else
                call vimrc#exception#throw('not supported number of arguments')
            endif
        catch
           call vimrc#exception#rethrow()
        endtry
    endfunction


    return l:obj
endfunction


"--------
" tests
"--------
"
" find: argument: <file name glob enable path>
"
"let s:cmd = s:findFactory().cmd('sniff*')
"let s:cmd = s:findFactory().cmd(['sniff*', 'vital*'])
"let s:cmd = s:findFactory().cmd({'iname' : 'Vital*'})
"let s:cmd = s:findFactory().cmd([{'name' : 'vital*'}, 'cache*'])
"
" find: argument: <paths and excludes>
"
"let s:cmd = s:findFactory().cmd('vimrc.vim',
            "\ './')
"let s:cmd = s:findFactory().cmd('vimrc.vim',
            "\ {'path' : './'})
"let s:cmd = s:findFactory().cmd('vimrc.vim',
            "\ {'path' : './', 'exclude' : './.vim/ftplugin'})
"let s:cmd = s:findFactory().cmd('vimrc.vim',
            "\ [{'path' : './', 'exclude' : './.vim/ftplugin'}])
"let s:cmd = s:findFactory().cmd('vimrc.vim',
            "\ ['~/temp/temp', {'path' : './', 'exclude' : './.vim/ftplugin'}])
"let s:cmd = s:findFactory().cmd(['vimrc.vim','*cpp'],
            "\ ['~/temp/temp', {'path' : './', 'exclude' : './.vim/ftplugin'}])
"
" find: argument: <exclude dir pattern>
"
"let s:cmd = s:findFactory().cmd('vimrc.vim', './',
            "\ 'dupa*')
"let s:cmd = s:findFactory().cmd('vimrc.vim', './',
            "\ [{'name' : 'dupa'}, 'dupa_2'])
"
" find: argument: <exclude file pattern>
"
"let s:cmd = s:findFactory().cmd('vimrc.vim', './', '',
            "\ 'dupa*')
"let s:cmd = s:findFactory().cmd('vimrc.vim', './', '',
            "\ [{'iname' : 'dupa'}, 'dupa_2'])
"echomsg 'cmd is '.s:cmd
"silent execute 'Dispatch '.s:cmd

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
