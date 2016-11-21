"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:globsFactory()
    return  { 'dir' : {
            \         'vcs' : ['.svn', '.git'],
            \         'vim' : [ vimrc#cache#instance().dirNamePrefix().'*' ]
            \         },
            \ 'file' : ['*.o', '*.obj', '*.pyc', '*.a', '*.so']
            \}
endfunction

function! s:ignoreFactory()
    let l:obj = extend({}, {'grep' : s:globsFactory(),
                \           'find' : s:globsFactory(),
                \           'wildignore' : s:globsFactory()})


    function! l:obj.grep.formatDir(glob)
        return '--exclude-dir='.a:glob
    endfunction

    function! l:obj.grep.formatFile(glob)
        return '--exclude='.a:glob
    endfunction

    function! l:obj.grep.format()
        let l:temp_vcs  = map(deepcopy(self.dir.vcs), 'self.formatDir(v:val)')
        let l:temp_vim  = map(deepcopy(self.dir.vim), 'self.formatDir(v:val)')
        let l:temp_file = map(deepcopy(self.file), 'self.formatFile(v:val)')

        return join(extend(extend(l:temp_vcs, l:temp_vim), l:temp_file), ' ')
    endfunction


    function! l:obj.find.formatDir(glob)
        return '-not \( -type d -name '.a:glob.' -prune \)'
    endfunction

    function! l:obj.find.formatFile(glob)
        return '-not \( -type f -name '.a:glob.' -prune \)'
    endfunction

    function! l:obj.find.format()
        let l:temp_vcs  = map(deepcopy(self.dir.vcs), 'self.formatDir(v:val)')
        let l:temp_vim  = map(deepcopy(self.dir.vim), 'self.formatDir(v:val)')
        let l:temp_file = map(deepcopy(self.file), 'self.formatFile(v:val)')

        return join(extend(extend(l:temp_vcs, l:temp_vim), l:temp_file), ' ')
    endfunction


    function! l:obj.wildignore.formatDir(glob)
        return '*/'.a:glob
    endfunction

    function! l:obj.wildignore.formatFile(glob)
        return a:glob
    endfunction

    function! l:obj.wildignore.format()
        let l:temp_vcs  = map(deepcopy(self.dir.vcs), 'self.formatDir(v:val)')
        let l:temp_file = map(deepcopy(self.file), 'self.formatFile(v:val)')

        return join(extend(l:temp_vcs, l:temp_file), ',')
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

let g:ignore = vimrc#ignore#instance()

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
