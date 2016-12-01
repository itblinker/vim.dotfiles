"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

"
" API
"
function! vimrc#find#instance()
    if empty(s:findLazyInstance)
        let s:findLazyInstance = s:find()
    endif

    return s:findLazyInstance
endfunction


let s:findLazyInstance = {}

function! s:find()
    let l:obj = { 'format' : {'pattern' : {},
                \             'ignore' :  {}
                \            }
                \}

    function! l:obj.format.pattern.iname(iname)
        return '-iname '''.a:iname.''''
    endfunction

    function! l:obj.format.pattern.inames(list)
        return map(copy(a:list), 'self.iname(v:val)')
    endfunction

    function! l:obj.format.pattern.name(name)
        return '-name '''.a:name.''''
    endfunction

    function! l:obj.format.pattern.names(list)
        return map(copy(a:list), 'self.name(v:val)')
    endfunction

    function! l:obj.format.names(obj)
        let l:names = []

        if has_key(a:obj, 'names')
            call extend(l:names, self.pattern.names(a:obj.names))
        endif
        if has_key(a:obj, 'inames')
            call extend(l:names, self.pattern.inames(a:obj.inames))
        endif

        if !empty(l:names)
            return '-type f \( '.join(l:names, ' -o ').' \)'
        else
            call vimrc#exception#throw('some name must be provided')
        endif
    endfunction


    function! l:obj.format.ignore.path(obj)
        return '-not \( -path '''.fnamemodify(a:obj.path, ':p:h').''' -prune \)'
    endfunction

    function! l:obj.format.ignore.paths(pathsList)
        return join(map(a:pathsList, 'self.path(v:val)'), ' ')
    endfunction


    function! l:obj.format.ignore.idir(ipattern)
        return '-not \( -type d -iname '''.a:ipattern.''' -prune \)'
    endfunction

    function! l:obj.format.ignore.idirs(ipatternList)
        return join(map(a:ipatternList, 'self.idir(v:val)'), ' ')
    endfunction

    function! l:obj.format.ignore.dir(pattern)
        return '-not \( -type d -name '''.a:pattern.''' -prune \)'
    endfunction

    function! l:obj.format.ignore.dirs(patternList)
        return join(map(a:patternList, 'self.dir(v:val)'), ' ')
    endfunction


    function! l:obj.format.ignore.ifile(ipattern)
        return '-not \( -type f -iname '''.a:ipattern.''' -prune \)'
    endfunction

    function! l:obj.format.ignore.ifiles(ipatternList)
        return join(map(a:ipatternList, 'self.ifile(v:val)'), ' ')
    endfunction

    function! l:obj.format.ignore.file(pattern)
        return '-not \( -type f -name '''.a:pattern.''' -prune \)'
    endfunction

    function! l:obj.format.ignore.files(patternList)
        return join(map(a:patternList, 'self.file(v:val)'), ' ')
    endfunction

    function! l:obj.format.excludes(obj)
        if !has_key(a:obj, 'exclude')
            return ''
        endif

        let l:cmd = ''

        if has_key(a:obj.exclude, 'paths') && !empty(a:obj.exclude.paths)
            let l:cmd = l:cmd.self.ignore.paths(a:obj.exclude.paths)
        endif

        if has_key(a:obj.exclude, 'dir')
            if has_key(a:obj.exclude.dir, 'patterns') && !empty(a:obj.exclude.dir.patterns)
                let l:cmd = l:cmd.' '.self.ignore.dirs(a:obj.exclude.dir.patterns)
            endif

            if has_key(a:obj.exclude.dir, 'ipatterns') && !empty(a:obj.exclude.dir.ipatterns)
                let l:cmd = l:cmd.' '.self.ignore.idirs(a:obj.exclude.dir.ipatterns)
            endif
        endif

        if has_key(a:obj.exclude, 'file')
            if has_key(a:obj.exclude.file, 'patterns') && !empty(a:obj.exclude.file.patterns)
                let l:cmd = l:cmd.' '.self.ignore.files(a:obj.exclude.file.patterns)
            endif

            if has_key(a:obj.exclude.file, 'ipatterns') && !empty(a:obj.exclude.file.ipatterns)
                let l:cmd = l:cmd.' '.self.ignore.ifiles(a:obj.exclude.file.ipatterns)
            endif
        endif

        return l:cmd
    endfunction


    function! l:obj.format.path(obj)
        if !has_key(a:obj, 'path')
            call vimrc#exception#throw('path must be provided')
        endif

        return fnamemodify(a:obj.path, ':p:h')
    endfunction


    function! l:obj.cmdComposer(obj)
        try
            return 'find '
                   \.' '.self.format.path(a:obj)
                   \.' '.self.format.excludes(a:obj)
                   \.' '.vimrc#ignore#instance().findFormat()
                   \.' '.self.format.names(a:obj)
        catch
           call vimrc#exception#throw('find argument has invalid structure')
        endtry
    endfunction


    function! l:obj.cmdComposerFromList(argList)
        let l:cmds = []

        for l:item in a:argList
            call add(l:cmds, self.cmd(l:item))
        endfor

        return join(l:cmds, ' && ')
    endfunction

    "
    " API
    "
    function! l:obj.cmd(arg)
        if type(a:arg) == type({})
            return self.cmdComposer(a:arg)
        elseif type(a:arg) == type([])
            return self.cmdComposerFromList(a:arg)
        else
           call vimrc#exception#throw('invalid argument type')
        endif
    endfunction
    "

    return l:obj
endfunction

"
" Test
"
"let s:find = vimrc#find#instance()
"let s:parameters = vimrc#gtags#cpp#config#factory().findParameters()

"echomsg 'find: '.string(s:find.cmd(s:parameters))
"echomsg 'find: '.s:find.cmd(s:parameters[0])

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
