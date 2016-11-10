let g:plugins#unitegtags#cpp#settings = {
\   'dbpath' : {
\       'path' : vimrc#cache#fetch().'/gtags/cpp'
\   },
\   'find_cmd' : {
\       'filetypes' : ['*.cpp', '*.hpp', '*.h', '*.c'],
\       'paths' : [getcwd()],
\       'paths_ignore' : ['test_module']
\   }
\ }

function! g:plugins#unitegtags#cpp#settings.dbpath.init()
    if !isdirectory(self.path)
        call mkdir(self.path, 'p')
    endif
endfunction


function! g:plugins#unitegtags#cpp#settings.dbpath.get()
    call self.init()
    return self.path
endfunction


function! g:plugins#unitegtags#cpp#settings.areTagsAvailable()
    return  filereadable(self.dbpath.path.'/GTAGS') &&
          \ filereadable(self.dbpath.path.'/GRTAGS') &&
          \ filereadable(self.dbpath.path.'/GPATH')
endfunction()


function! g:plugins#unitegtags#cpp#settings.startup()
    if self.areTagsAvailable()
        call self.setEnvironment()
    endif
endfunction


function! s:formFindNamePart(extension)
    return '-iname '''.a:extension.''''
endfunction


function! s:formIgnorePathsPart(extension)
    return '! -ipath ''*'.a:extension.'*'''
endfunction


function! g:plugins#unitegtags#cpp#settings.find_cmd.get()
    let l:cmd = 'find '.join(self.paths, ' ')
             \ .' -type f \( '
             \ .join(map(deepcopy(self.filetypes), 's:formFindNamePart(v:val)'), ' -o ')
             \ .' \) '
             \ .join(map(deepcopy(self.paths_ignore), 's:formIgnorePathsPart(v:val)'), ' ')
    return l:cmd
endfunction


function! g:plugins#unitegtags#cpp#settings.filenameWithList()
    return self.dbpath.get().'/'.'list.last.files'
endfunction


function! g:plugins#unitegtags#cpp#settings.logfileForList()
    return self.dbpath.get().'/'.'logs.last.fileList'
endfunction


function! g:plugins#unitegtags#cpp#settings.logfileForGtags()
    return self.dbpath.get().'/'.'logs.last.gtags'
endfunction


function! g:plugins#unitegtags#cpp#settings.logfileForGtagsFileUpdate()
    return self.dbpath.get().'/'.'logs.last.singleFile.gtags'
endfunction


function! g:plugins#unitegtags#cpp#settings.makeFileList() abort
    execute 'silent! Start! '.self.find_cmd.get().' > '.self.filenameWithList().' 2> '.self.logfileForList()
endfunction


function! g:plugins#unitegtags#cpp#settings.setEnvironment() abort
    let $GTAGSFORCECPP=''
    let $GTAGSROOT=getcwd()
    let $GTAGSDBPATH=self.dbpath.get()
endfunction


function! g:plugins#unitegtags#cpp#settings.performFullTag() abort
    execute 'silent! Start! gtags --file '.self.filenameWithList().' '.self.dbpath.get()
        \  .' --verbose --warning --statistics > '.self.logfileForGtags().' 2>&1'
endfunction


function! g:plugins#unitegtags#cpp#settings.performTagUpdateForCurrentFile() abort
    execute 'silent! Start! gtags '.self.dbpath.get().' --single-update '.expand('%;p')
         \ .' --verbose --warning --statistics > '.self.logfileForGtagsFileUpdate().' 2>&1'
endfunction


function! g:plugins#unitegtags#cpp#settings.tag()
    try
        call self.makeFileList()
        call self.setEnvironment()
        call self.performFullTag()
    catch
        call vimrc#exceptions#echomsg('gtags-cpp :tag()')
    endtry
endfunction


function! GtagsCppMappings()
    nnoremap <buffer> <C-]> :Unite -no-wipe -buffer-name=gtags_definitions -immediately gtags/def<CR>
    nnoremap <buffer> <leader>gr :Unite -no-wipe -buffer-name=gtags_references gtags/ref<CR>
    nnoremap <buffer> <leader>gc :Unite -no-wipe -buffer-name=gtags_context gtags/context<CR>
endfunction


function! s:localCommands()
    command! -buffer -nargs=0 GtagsFullTag :call g:plugins#unitegtags#cpp#settings.tag()
endfunction


function! s:startupSettings()
    call g:plugins#unitegtags#cpp#settings.startup()
endfunction


function! plugins#unitegtags#cpp#setup()
    try
        call vimrc#utils#autocmd#filetype(['cpp'], 'GtagsCppMappings')
        call s:localCommands()
        call s:startupSettings()
    catch
        call vimrc#exceptions#echomsg('gtags-cpp :setup()')
    endtry
endfunction
