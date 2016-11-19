let g:vimrc#grep#fixed#flags = '-I -nHr'

function! s:getGrepCmdForFixedString(pattern, flags, path)
    return 'grep! -F '''.escape(a:pattern, '*#$\\').''' '.a:flags.' '.a:path
endfunction


function! s:execute(pattern, root_path, flags, exclude_dir_globs, include_globs)
    execute s:getGrepCmdForFixedString(a:pattern,
                                     \ a:flags.' '.a:exclude_dir_globs.' '.a:include_globs,
                                     \ a:root_path)
endfunction


function! vimrc#grep#fixed#execute(pattern, ...) abort
    try
        if a:0 == 0
            call s:execute(a:pattern,
                         \ getcwd(),
                         \ g:vimrc#grep#fixed#flags,
                         \ vimrc#ignore#instance().grep.get(),
                         \ g:vimrc#grep#fixed#default_include_dir)
        endif

    catch
        call vimrc#exception#error()
    endtry
endfunction
