let s:options =
            \ {
            \ 'strong' : '-type\ f\ -name\ ',
            \ 'weak'   : '-type\ f\ -iname\ '
            \ }


function! s:getUniteFindCommand(filename, path, options) abort
    return 'Unite find:'.a:path.':'.a:options.a:filename
endfunction


function! plugins#unite#find#fileInCwd(filename)
    try
        execute s:getUniteFindCommand(a:filename, './', s:options.strong)
    catch
        call vimrc#exceptions#echomsg()
    endtry
endfunction


function! s:applyBufferSettings(findCmd, bufferName) abort
    return a:findCmd.' -buffer-name='.a:bufferName.' -no-wipe'
endfunction


function! s:findFileWithUniteBufferCreation(bangFlag, filename, path) abort
    if a:bangFlag == 1
       let l:kyeword = a:filename
       execute s:applyBufferSettings
                   \ (
                   \ s:getUniteFindCommand(l:kyeword, a:path, s:options.strong),
                   \ 'findFile::'.l:kyeword,
                   \ )
   else
       let l:kyeword = '*'.a:filename.'*'
       execute s:applyBufferSettings
                   \ (
                   \ s:getUniteFindCommand(l:kyeword, a:path, s:options.weak),
                   \ 'findFile::'.l:kyeword,
                   \ )
   endif
endfunction


function! plugins#unite#find#file(bangFlag, ...)
    try
        if a:0 == 1
            call s:findFileWithUniteBufferCreation(a:bangFlag, a:1, './')
        elseif a:0 == 2
            call s:findFileWithUniteBufferCreation(a:bangFlag, a:1, a:2)
        else
            vimrc#exceptions#throw('plugins#unite#find#file: invalid number of arguments')
        endif
    catch
        call vimrc#exceptions#echomsg()
    endtry
endfunction
