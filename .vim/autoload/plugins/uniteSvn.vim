function! plugins#uniteSvn#isNeeded()
    return isdirectory(getcwd().'/.svn')
endfunction

