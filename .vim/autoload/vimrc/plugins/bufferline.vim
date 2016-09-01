function! vimrc#plugins#Setup()
    call s:settings()
endfunction


function! s:settings()
    let g:bufferline_show_bufnr = 0
    let g:bufferline_fname_mod = ':t'
endfunction

