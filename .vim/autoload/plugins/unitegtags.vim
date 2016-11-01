let s:filetypes = ['cpp', 'c']

function! GtagsMappingsFroCandCpp()
    nnoremap <buffer> <C-]> :Unite -no-wipe -buffer-name=gtags_definitions -immediately gtags/def<CR>
    nnoremap <buffer> <leader>gr :Unite -no-wipe -buffer-name=gtags_references gtags/ref<CR>
    nnoremap <buffer> <leader>gc :Unite -no-wipe -buffer-name=gtags_context gtags/context<CR>
endfunction


function! s:settings()
    let g:unite_source_gtags_project_config = {
                \ '_': { 'treelize': 1, 'uniteSource__Gtags_LineNr': 0, 'uniteSource__Gtags_Path': 0 }
                \ }
endfunction

function! plugins#unitegtags#isNeeded()
    return vimrc#bin#gtags#isAvailable() && vimrc#utils#isFiletypeMatch(s:filetypes)
endfunction


function! plugins#unitegtags#PostSourceSetup()
    call s:settings()
    call vimrc#utils#autocmd#filetype(s:filetypes, 'GtagsMappingsFroCandCpp')
endfunction
