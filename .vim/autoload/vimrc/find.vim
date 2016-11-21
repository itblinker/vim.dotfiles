"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! vimrc#find#file(filename, path)
    try
        return vimrc#find#file#getList(a:filename, a:path)
    catch
        call vimrc#exception#warning()
    endtry
endfunction


function! vimrc#find#isFileExist(filename, path)
    try
        return vimrc#find#file#isReachable(a:filename, a:path)
    catch
        call vimrc#exception#warning()
    endtry
endfunction


function! s:findFactory()
    let l:obj = { 'formatter' : {} }

    function! l:obj.formatter.exclude(globPattern, type)
        if len(a:globPattern)
            return '-not \( -type '.a:type.' -iname '.a:globPattern.' -prune \)'
        else
            return ''
        endif
    endfunction

    function! l:obj.formatter.excludeDir(globPattern)
        return self.exclude(a:globPattern, 'd')
    endfunction

    function! l:obj.formatter.excludeFile(globPattern)
        return self.exclude(a:globPattern, 'f')
    endfunction


    function! l:obj.excludeDirs(globPattern)
        let l:pattern = deepcopy(a:globPattern)

        if type(l:pattern) == type('')
            let l:pattern = [l:pattern]
        endif

        return join(map(l:pattern, 'self.formatter.excludeDir(v:val)'), ' ')
    endfunction


    function! l:obj.excludeFiles(globPattern)
        let l:pattern = deepcopy(a:globPattern)

        if type(l:pattern) == type('')
            let l:pattern = [l:pattern]
        endif

        return join(map(l:pattern, 'self.formatter.excludeFile(v:val)'), ' ')
    endfunction


    function! l:obj.formatter.name(globPattern)
        return '\( -type f -name '.a:globPattern.' \)'
    endfunction

    function! l:obj.names(names)
        let l:names = deepcopy(a:names)

        if type(l:names) == type('')
            let l:names = [l:names]
        endif

        return join(map(deepcopy(l:names), 'self.formatter.name(v:val)'), ' -o ')
    endfunction


    function! l:obj.get_cmd_patterns_part(patterns, excludeDirs, excludeFiles)
        if len(self.excludeDirs(a:excludeDirs)) == 0 && len(self.excludeFiles(a:excludeFiles)) == 0
            return self.names(a:patterns)
        else
            return self.excludeDirs(a:excludeDirs).' '.self.excludeFiles(a:excludeFiles).' -a \( '.self.names(a:patterns).' \)'
        endif
    endfunction


    function! l:obj.paths(paths)
        let l:paths = deepcopy(a:paths)

        if type(l:paths) == type('')
            let l:paths = [l:paths]
        endif

        return join(l:paths, ' ')
    endfunction


    function! l:obj.get_cmd(patterns, paths, excludeDirs, excludeFiles)
        return 'find '.self.paths(a:paths).' '.self.get_cmd_patterns_part(a:patterns, a:excludeDirs, a:excludeFiles)
    endfunction

    "
    "API
    "
    function! l:obj.cmd(...)
        if a:0 == 1
            return self.get_cmd(a:1, './', '', '')
        elseif a:0 == 2
            return self.get_cmd(a:1, a:2, '', '')
        elseif a:0 == 3
            return self.get_cmd(a:1, a:2, a:3, '')
        elseif a:0 == 4
            return self.get_cmd(a:1, a:2, a:3, a:4)
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


"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
