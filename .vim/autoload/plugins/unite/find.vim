let s:options =
            \ {
            \ 'strong' : '-type\ f\ -name\ ',
            \ 'weak'   : '-type\ f\ -iname\ '
            \ }

function! s:getUniteFindCommand(filename, path, options)
    return 'Unite find:'.a:path.':'.a:options.a:filename
endfunction


function! plugins#unite#find#inCwd(filename)
    try
        execute s:getUniteFindCommand(a:filename, './', s:options.strong)
    catch
        call vimrc#exceptions#echomsg()
    endtry
endfunction
