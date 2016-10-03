function plugins#unitegtags#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function s:settings()
    let g:unite_source_gtags_project_config = {
                \ '_': { 'treelize': 1, 'uniteSource__Gtags_LineNr': 0, 'uniteSource__Gtags_Path': 0 }
                \ }
endfunction


function! s:mappings()
    augroup unitegtags_autocmds
        autocmd!
        autocmd FileType cpp,c call s:mappings_c_cpp()
    augroup END
endfunction


function! s:mappings_c_cpp()
    nnoremap <buffer> <C-]> :Unite -immediately gtags/def<CR>
    nnoremap <buffer> <leader>gr :Unite gtags/ref<CR>
    nnoremap <buffer> <leader>gc :Unite gtags/context<CR>
endfunction

