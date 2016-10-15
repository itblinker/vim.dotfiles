let s:gtags_supported_filetypes = ['cpp', 'c']


function! plugins#unitegtags#hook()
    if vimrc#utils#isFiletypeMatch(s:gtags_supported_filetypes) && executable('gtags')
        return 1
    else
        return 0
    endif
endfunction


function! plugins#unitegtags#PostSourceSetup()
    call s:settings()
    call vimrc#utils#autocmd#filetype('au_filetype_mappings_gtags', s:gtags_supported_filetypes, 'MappingsForGtags')
endfunction


function! MappingsForGtags()
    nnoremap <buffer> <C-]> :Unite -immediately gtags/def<CR>
    nnoremap <buffer> <leader>gr :Unite gtags/ref<CR>
    nnoremap <buffer> <leader>gc :Unite gtags/context<CR>
endfunction


function! s:settings()
    let g:unite_source_gtags_project_config = {
                \ '_': { 'treelize': 1, 'uniteSource__Gtags_LineNr': 0, 'uniteSource__Gtags_Path': 0 }
                \ }
endfunction
