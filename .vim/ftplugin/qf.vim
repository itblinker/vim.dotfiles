nnoremap <buffer> q :q<cr>

nnoremap <buffer> <leader>< :call manager#utils#OlderList()<CR>
nnoremap <buffer> <leader>> :call manager#utils#NewerList()<CR>

setlocal switchbuf=useopen
