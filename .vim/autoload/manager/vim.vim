function manager#vim#PathsConfiguration()
    let g:vim_manager_home_dir = '~/.store.vim'
    let g:vim_manager_cwd_dir = getcwd().'/store.vim'
endfunction


function manager#vim#GetCentralVimStore()
    return g:vim_manager_home_dir
endfunction


function manager#vim#GeCwdVimStore()
    return g:vim_manager_cwd_dir
endfunction
