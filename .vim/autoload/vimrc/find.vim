"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:findFactory()
    let l:obj = { 'formatter' : {} }

    function! l:obj.formatter.excludePattern(globPattern, type)
        if len(a:globPattern)
            return '-not \( -type '.a:type.' -iname '.a:globPattern.' -prune \)'
        else
            return ''
        endif
    endfunction

    function! l:obj.formatter.excludeDirPattern(globPattern)
        return self.excludePattern(a:globPattern, 'd')
    endfunction

    function! l:obj.formatter.excludeFilePattern(globPattern)
        return self.excludePattern(a:globPattern, 'f')
    endfunction

    function! l:obj.formatter.excludeDirRelativePath(wholename)
        return '-not \( -path '.a:wholename.' -prune \)'
    endfunction

    function! l:obj.formatter.makeList(arg)
        let l:item = deepcopy(a:arg)

        if type(l:item) == type('')
            let l:item = [l:item]
        endif

        return l:item
    endfunction

    function! l:obj.excludeDirsPattern(globPattern)
        return join(map(self.formatter.makeList(a:globPattern), 'self.formatter.excludeDirPattern(v:val)'), ' ')
    endfunction

    function! l:obj.excludeFilesPattern(globPattern)
        return join(map(self.formatter.makeList(a:globPattern), 'self.formatter.excludeFilePattern(v:val)'), ' ')
    endfunction

    function! l:obj.excludeDirRelativePath(wholename)
        return join(map(self.formatter.makeList(a:wholename), 'self.formatter.excludeDirRelativePath(v:val)'), ' ')
    endfunction

    function! l:obj.formatter.name(globPattern)
        return '\( -type f -name '.a:globPattern.' \)'
    endfunction

    function! l:obj.names(names)
        return join(map(self.formatter.makeList(a:names), 'self.formatter.name(v:val)'), ' -o ')
    endfunction

    function! l:obj.paths(paths)
        return join(self.formatter.makeList(a:paths), ' ')
    endfunction

    function! l:obj.get_cmd(patterns, paths, excludeDirsPattern, excludeFilesPattern, excludeDirRelativePath)
        return 'find '
                    \.self.paths(a:paths).' '
                    \.self.excludeDirsPattern(a:excludeDirsPattern).' '
                    \.self.excludeFilesPattern(a:excludeFilesPattern).' '
                    \.self.excludeDirRelativePath(a:excludeDirRelativePath).' '
                    \.vimrc#ignore#instance().find.format().' '
                    \.' -a \( '.self.names(a:patterns).' \)'
    endfunction

    "
    "API
    "
    function! l:obj.cmd(...)
        if a:0 == 1
            return self.get_cmd(a:1, './', '', '', '')
        elseif a:0 == 2
            return self.get_cmd(a:1, a:2, '', '', '')
        elseif a:0 == 3
            return self.get_cmd(a:1, a:2, a:3, '', '')
        elseif a:0 == 4
            return self.get_cmd(a:1, a:2, a:3, a:4, '')
        elseif a:0 == 5
            return self.get_cmd(a:1, a:2, a:3, a:4, a:5)
        else
            call vimrc#exception#throw('invalid number of arguments')
        endif
    endfunction

    return l:obj
endfunction


let s:findLazyInstane = {}
function! vimrc#find#instance()
    if empty(s:findLazyInstane)
        let s:findLazyInstane = s:findFactory()
    endif

    return s:findLazyInstane
endfunction



"-------------
"   tests
"-------------

"let s:cmd = vimrc#find#instance().cmd('vimrc.vim', ['./'], '', [''], './.vim/autoload/vital')
"echomsg 'cmd is '.s:cmd
"echomsg 'found: '.string(systemlist(s:cmd))

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
