function! plugins#tmuxFocusEvents#isNeeded()
    return vimrc#bin#tmux#isAvailable() && vimrc#bin#tmux#isWorkingUnder()
endfunction
