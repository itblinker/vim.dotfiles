let s:filetypes = ['cpp', 'c']

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


function! plugins#unitegtags#hook()
    return vimrc#utils#isFiletypeMatch(s:filetypes)
endfunction


function! plugins#unitegtags#PostSourceSetup()
    call s:settings()
    call vimrc#utils#autocmd#filetype(s:filetypes, 'MappingsForGtags')
endfunction
