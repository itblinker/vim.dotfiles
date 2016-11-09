let g:plugins#unitegtags#cpp#settings = {
\   'dbpath' : vimrc#cache#fetch().'/gtags/cpp',
\   'find_cmd' : {
\       'filetypes' : ['*.cpp', '*.hpp', '*.h', '*.c'],
\       'paths' : [getcwd()],
\       'paths_ignore' : []
\   }
\ }

function! s:wrapExtension(string)
    return ''''.a:string.''''
endfunction


function! g:plugins#unitegtags#cpp#settings.find_cmd.form()
    let l:cmd = 'find '.join(self.paths, ' ')
             \ .' -type f \( '
             \ .join(map(deepcopy(self.filetypes), 's:wrapExtension(v:val)'), ' -oSta ')
             \ .' \)'
    return l:cmd
endfunction


function! g:plugins#unitegtags#cpp#settings.find_cmd.getPaths()
    let l:paths = ''

    for l:item in self.paths
        let l:paths = ' '.l:item
    endfor

    return l:paths
endfunction


function! g:plugins#unitegtags#cpp#settings.find_cmd.getIgnoredPaths()
    echomsg 'paths are: '.join(self.paths, ' ')
    echomsg 'filetypes are: '.join(self.filetypes, ' -o ')
    echomsg 'mappings starts'
    let l:string = map(copy(self.filetypes), 's:wrapExtension(v:val)')
    echomsg 'echo echo: '.join(l:string, ' ')
endfunction


function! g:plugins#unitegtags#cpp#settings.init()
    if !isdirectory(self.dbpath)
        call mkdir(self.dbpath, 'p')
    endif
endfunction


function! GtagsCppMappings()
    nnoremap <buffer> <C-]> :Unite -no-wipe -buffer-name=gtags_definitions -immediately gtags/def<CR>
    nnoremap <buffer> <leader>gr :Unite -no-wipe -buffer-name=gtags_references gtags/ref<CR>
    nnoremap <buffer> <leader>gc :Unite -no-wipe -buffer-name=gtags_context gtags/context<CR>
endfunction


function! s:createFileListToTag()
    call system('find -type f ./ > file.list')
endfunction


function! s:commands()

endfunction


function! plugins#unitegtags#cpp#setup()
    call vimrc#utils#autocmd#filetype(['cpp'], 'GtagsCppMappings')
endfunction
