"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! s:localCacheFactory()
    let l:obj = { 'dirName' : '.vim.cache.local', 'parentPath' : getcwd() }

    function! l:obj.path()
        return self.parentPath.'/'.self.dirName
    endfunction

    function l:obj.isAvailable()
        return isdirectory(self.parentPath.'/'.self.dirName)
    endfunction

    function l:obj.create()
        call mkdir(self.dirName, self.parentPath)
    endfunction

    function! l:obj.fetch()
        if !self.isAvailable()
            try
                call self.create()
            catch
                call vimrc#exceptions#throw('local cache cannot be created')
            endtry
        endif

        return self.path()
    endfunction

    return l:obj
endfunction


function! s:globalCacheFactory()
    let l:obj = { 'dirName' : '.vim.cache.global', 'parentPath' : expand('$HOME') }

    function! l:obj.path()
        return self.parentPath.'/'.self.dirName
    endfunction

    function l:obj.isAvailable()
        return isdirectory(self.parentPath.'/'.self.dirName)
    endfunction

    function l:obj.create()
        call mkdir(self.dirName, self.parentPath)
    endfunction

    function! l:obj.fetch()
        if !self.isAvailable()
            try
                call self.create()
            catch
                call vimrc#exceptions#throw('global cache cannot be created')
            endtry
        endif

        return self.path()
    endfunction

    return l:obj
endfunction


function! s:cacheFactory()
    let l:obj =  extend({}, { 'local'  : s:localCacheFactory(),
                \             'global' : s:globalCacheFactory() })

    function! l:obj.fetch()
        if self.local.isAvailable()
            return self.local.path()
        endif

        if argc() > 0
            return self.global.fetch()
        endif

        try
            return self.local.fetch()
        catch
            try
                return self.global.fetch()
            catch
                call vimrc#exceptions#throw('cannot take vim cache dir (creation problem or ...)')
            endtry
        endtry
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
