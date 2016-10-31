function! plugins#uniteGiti#isNeeded()
    return isdirectory(getcwd().'/.git')
endfunction
