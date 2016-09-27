function! plugins#editgq#PostHookSetup()
    let g:editqf_no_mappings = 1
    let g:editqf_saveqf_filename  = ".vim-quickfix"
    let g:editqf_saveloc_filename = ".vim-locationList"
endfunction
