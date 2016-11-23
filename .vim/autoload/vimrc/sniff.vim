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
            call vimrc#exception#throw('Arg type is not a list')
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
            call vimrc#exception#throw('improper type: arg: '.string(a:path))
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


    function! l:obj.path(paths)
        if type(a:paths) == type('')
            return a:paths
        elseif type(a:paths) == type({})
            return a:paths.path.' '.self.formatter.paths(self.formatter.makePathsList(a:paths.exclude))
        else
            call vimrc#exception#throw('arg type its not a list')
        endif
    endfunction


    function! l:obj.getCmd(names, paths)
        return 'find '
                    \.self.path(a:paths).' '
                    \.self.names(a:names)
    endfunction


    return l:obj
endfunction


"--------
" tests
"--------

"let s:cmd = s:findFactory().getCmd(['sniff*', {'name' : 'cac*vim'}, {'iname' : 'auto*.vim'}],
            "\'./'')

let s:cmd = s:findFactory().getCmd(['sniff*', {'iname' : 'cac*vim'}, {'name' : 'auto*.vim'}],
            \ {'path' : './', 'exclude' : './.vim/autoload/vital'} )

"let s:cmd = s:findFactory().getCmd(['sniff*', {'iname' : 'cac*vim'}, {'name' : 'auto*.vim'}],
            "\ {'path' : './', 'exclude' : ['./.vim/autoload/vital']} )


echomsg 'cmd is '.s:cmd
silent execute 'Dispatch '.s:cmd

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
