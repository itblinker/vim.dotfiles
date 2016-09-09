function vimrc#unitegtags#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function s:settings()
    let g:unite_source_gtags_project_config = {
                \ '_': { 'treelize': 1, 'uniteSource__Gtags_LineNr': 0, 'uniteSource__Gtags_Path': 0 }
                \ }
endfunction


function s:mappings()

    augroup filetypeSpecific
        autocmd!
        autocmd FileType cpp,c call s:mappingsCAndCpp()
    augroup END

endfunction


function! s:mappingsCAndCpp()
    nnoremap <buffer> <C-]> :Unite -immediately gtags/def<CR>
    nnoremap <buffer> <leader>gr :Unite gtags/ref<CR>
    nnoremap <buffer> <leader>gc :Unite gtags/context<CR>

    "nnoremap <buffer> <leader>gr :Unite gtags/ref<CR>
    "nnoremap <buffer> <leader>gi :Unite gtags/ref<CR>
endfunction

