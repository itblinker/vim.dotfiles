"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:localCacheFactory()
    let l:obj = { 'dirName' : '.vim.cache.local', 'parentPath' : getcwd() }


    function! l:obj.globDirName()
        return '*'.self.dirName.'*'
    endfunction

    function! l:obj.path()
        return self.parentPath.'/'.self.dirName
    endfunction

    function l:obj.isAvailable()
        return isdirectory(self.path())
    endfunction

    function l:obj.create() abort
        call mkdir(self.path(), 'p', 0700)
    endfunction

    function! l:obj.fetch() abort
        if !self.isAvailable()
            try
                call self.create()
            catch
                call vimrc#exception#throw('local cache cannot be created')
            endtry
        endif

        return self.path()
    endfunction

    return l:obj
endfunction


function! s:globalCacheFactory()
    let l:obj = { 'parentPath' : expand('$HOME').'/.vim.cache.global' }

    function! l:obj.dirName()
        return substitute(getcwd(), '/', '.', 'g')
    endfunction

    function! l:obj.globDirName()
        return '*'.self.dirName().'*'
    endfunction

    function! l:obj.path()
        return self.parentPath.'/'.self.dirName()
    endfunction

    function l:obj.isAvailable()
        return isdirectory(self.path())
    endfunction

    function l:obj.create() abort
         call mkdir(self.path(), 'p', 0700)
    endfunction

    function! l:obj.fetch() abort
        if !self.isAvailable()
            try
                call self.create()
            catch
                call vimrc#exception#throw('global cache cannot be created')
            endtry
        endif

        return self.path()
    endfunction

    return l:obj
endfunction


function! s:cacheFactory()
    let l:obj =  extend({}, { 'local'  : s:localCacheFactory(),
                 \            'global' : s:globalCacheFactory(),
                 \            'cache_fetched_path' : ''})

    function! l:obj.fetching()
        if self.local.isAvailable()
            return self.local.path()
        endif

        try
            if argc() > 0
                return self.global.fetch()
            else
                try
                    return self.local.fetch()
                catch
                    try
                        let l:path =  self.global.fetch()
                        call vimrc#message#instance().warning('local cache cannot be used <-> global in use')
                        return l:path
                    catch
                        call vimrc#exception#error()
                    endtry
                endtry
            endif
        endtry
    endfunction

    function! l:obj.fetch()
        if empty(self.cache_fetched_path)
            let self.cache_fetched_path = self.fetching()
        endif

        return self.cache_fetched_path
    endfunction

    return l:obj
endfunction


let s:cacheLazyInstance = {}
function! vimrc#cache#instance()
    if empty(s:cacheLazyInstance)
        let s:cacheLazyInstance = s:cacheFactory()
    endif

    return s:cacheLazyInstance
endfunction


"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
