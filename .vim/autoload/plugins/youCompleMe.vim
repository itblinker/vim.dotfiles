function! plugins#youCompleMe#isNeeded()
    return filereadable(getcwd().'/.ycm_extra_conf.py')
endfunction
