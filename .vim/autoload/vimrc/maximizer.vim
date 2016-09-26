function! manager#maximizer#Setup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:maximizer_set_default_mapping = 0
endfunction


function! s:mappings()
    nnoremap <silent><leader>Z :MaximizerToggle<CR>
endfunction