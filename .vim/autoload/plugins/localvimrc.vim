function! plugins#localvimrc#PostSourceSetup()
    call s:settings()
endfunction


function! s:settings()
    let g:localvimrc_file = "project_settings.vim"
    let g:localvimrc_event = ["VimEnter"]

    let g:localvimrc_ask = 1
    let g:localvimrc_persistent = 2
    let g:localvimrc_sandbox = 0

    "let g:localvimrc_file_dir  = getcwd().'/.store.vim'
endfunction
