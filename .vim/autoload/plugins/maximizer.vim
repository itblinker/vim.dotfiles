function! plugins#maximizer#PreSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:maximizer_restore_on_winleave = 1
    let g:maximizer_set_default_mapping = 0
endfunction


function! s:mappings()
    nnoremap <leader>M :MaximizerToggle<CR>
endfunction
