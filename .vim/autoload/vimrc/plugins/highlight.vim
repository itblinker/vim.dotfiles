function! manager#plugin#highlight#Setup()
    call s:mappigns()
endfunctio


function! s:mappigns()
    nnoremap <leader>hw,<call <SID>Highlight("w") \| nohls<CR>
endfunction
