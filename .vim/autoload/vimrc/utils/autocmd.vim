function! vimrc#utils#autocmd#bufWritePost(extensions, funcref)
    exec 'augroup vimrcAuFiletype_'.a:funcref
    au!

    if type(a:extensions) == type("")
        exec 'au BufWritePost '.a:extensions.' call '.a:funcref.'()'
    else
        exec 'au BufWritePost '.join(a:extensions, ',').' call '.a:funcref.'()'
    endif

    augroup END
endfunction


function! vimrc#utils#autocmd#filetype(extensions, funcref)
    exec 'augroup vimrcAuFiletype_'.a:funcref
    au!

    if type(a:extensions) == type("")
        exec 'au FileType '.a:extensions.' call '.a:funcref.'()'
    else
        exec 'au FileType '.join(a:extensions, ',').' call '.a:funcref.'()'
    endif

    augroup END
endfunction
