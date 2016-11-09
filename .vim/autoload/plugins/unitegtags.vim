let s:filetypes = ['cpp', 'c']

function! s:settings()
    let g:unite_source_gtags_project_config = {  '_': { 'treelize': 1,
                                                      \ 'uniteSource__Gtags_LineNr': 0,
                                                      \ 'uniteSource__Gtags_Path': 0,
                                                      \ 'absolute_path' : 0
                                                      \}
                \ }
endfunction


function! plugins#unitegtags#isNeeded()
    return vimrc#bin#gtags#isAvailable() && vimrc#utils#isFiletypeMatch(s:filetypes)
endfunction


function! plugins#unitegtags#PostSourceSetup()
    call s:settings()
    call plugins#unitegtags#cpp#setup()
endfunction
