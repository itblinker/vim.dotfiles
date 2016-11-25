"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:ignoreFactory()

    let l:obj = {'globs' : {
                \   'dirs'  : ['.svn', '.git', vimrc#cache#instance().local.dirName() ],
                \   'files' : ['*.o', '*.obj', '*.pyc', '*.a', '*.so', '*.exe'] }
                \}

    call extend(l:obj.globs, {'grep' : {} })
    let l:obj.globs.grep.cache = ''

    function! l:obj.globs.grep.formatDir(dir)
        return '--exclude-dir='''.a:dir.''''
    endfunction

    function! l:obj.globs.grep.formatDirs(dirs)
        return map(deepcopy(a:dirs), 'self.formatDir(v:val)')
    endfunction

    function! l:obj.globs.grep.formatFile(file)
        return '--exclude='''.a:file.''''
    endfunction

    function! l:obj.globs.grep.formatFiles(files)
        return map(deepcopy(a:files), 'self.formatFile(v:val)')
    endfunction

    function! l:obj.globs.grep.get(globs)
        return  join(extend(self.formatDirs(a:globs.dirs), self.formatFiles(a:globs.files)), ' ')
    endfunction


    call extend(l:obj.globs, {'find' : {} })
    let l:obj.globs.find.cache = ''

    function! l:obj.globs.find.formatDir(dir)
        return '-not \( -type d -name '''.a:dir.''' -prune \)'
    endfunction

    function! l:obj.globs.find.formatDirs(dirs)
        return map(deepcopy(a:dirs), 'self.formatDir(v:val)')
    endfunction

    function! l:obj.globs.find.formatFile(file)
        return '-not \( -type f -name '''.a:file.''' -prune \)'
    endfunction

    function! l:obj.globs.find.formatFiles(files)
        return map(deepcopy(a:files), 'self.formatFile(v:val)')
    endfunction

    function! l:obj.globs.find.get(globs)
        return  join(extend(self.formatDirs(a:globs.dirs), self.formatFiles(a:globs.files)), ' ')
    endfunction


    call extend(l:obj.globs, {'wildignore' : {} })
    let l:obj.globs.wildignore.cache = ''

    function! l:obj.globs.wildignore.formatDir(dir)
        return '*/'.a:dir
    endfunction

    function! l:obj.globs.wildignore.formatDirs(dirs)
        return map(deepcopy(a:dirs), 'self.formatDir(v:val)')
    endfunction

    function! l:obj.globs.wildignore.formatFile(file)
        return a:file
    endfunction

    function! l:obj.globs.wildignore.formatFiles(files)
        return map(deepcopy(a:files), 'self.formatFile(v:val)')
    endfunction

    function! l:obj.globs.wildignore.get(globs)
        return  join(extend(self.formatDirs(a:globs.dirs), self.formatFiles(a:globs.files)), ',')
    endfunction


    "
    "   API
    "
    function! l:obj.grepFormat()
        if empty(self.globs.grep.cache)
            let self.globs.grep.cache = self.globs.grep.get(self.globs)
        endif

        return self.globs.grep.cache
    endfunction


    function! l:obj.findFormat()
        if empty(self.globs.find.cache)
            let self.globs.find.cache = self.globs.find.get(self.globs)
        endif

        return self.globs.find.cache
    endfunction


    function! l:obj.wildignoreFormat()
        if empty(self.globs.wildignore.cache)
            let self.globs.wildignore.cache = self.globs.wildignore.get(self.globs)
        endif

        return self.globs.wildignore.cache
    endfunction

    return l:obj
endfunction


let s:ignoreLazyInstance = {}
function! vimrc#ignore#instance()
    if empty(s:ignoreLazyInstance)
        let s:ignoreLazyInstance = s:ignoreFactory()
    endif

    return s:ignoreLazyInstance
endfunction


"----------
" TESTS
"----------
"echomsg 'grep-format: '.vimrc#ignore#instance().grepFormat()
"echomsg 'find-format: '.g:test.findFormat()
"echomsg 'wildignore-format: '.g:test.wildignoreFormat()
"echomsg 'grep-format: '.vimrc#ignore#instance().grepFormat()
"echomsg 'grep-format: '.vimrc#ignore#instance().grepFormat()
"echomsg 'grep-format: '.vimrc#ignore#instance().grepFormat()

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
