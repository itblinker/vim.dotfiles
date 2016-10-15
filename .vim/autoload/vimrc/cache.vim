"{{{
function! s:getCache() abort
    if vimrc#cache#local#isAvailable()
        return vimrc#cache#local#getPath()
    endif

    if argc() != 0
        return vimrc#cache#global#fetch()
    endif

    try
        return vimrc#cache#local#fetch()
    catch
        try
            return vimrc#cache#global#fetch()
        catch
            call vimrc#exceptions#throw('cannot take vim cache dir (creation problem or ...)')
        endtry
    endtry
endfunction
"}}}

function! vimrc#cache#get()
    try
        return s:getCache()
    catch
        call vimrc#exceptions#echomsg('problem: vimrc#cache#get()')
    endtry
endfunction
