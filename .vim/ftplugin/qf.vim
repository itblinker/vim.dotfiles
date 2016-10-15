nnoremap <buffer> q :q<cr>

nnoremap <buffer> <leader>< :call vimrc#openOlderLlorQfList()<CR>
nnoremap <buffer> <leader>> :call vimrc#openNewerLlOrQfList()<CR>

setlocal switchbuf=useopen
