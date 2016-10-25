function! plugins#unitequickix#PostSourceSetup()
    call s:mappings()
endfunction


function! s:mappings()
   nnoremap <leader>q :Unite -buffer-name=quickfix quickfix<CR>
   nnoremap <leader>l :Unite -buffer-name=location_list location_list<CR>
endfunction

