function! plugins#tmuxNavigator#isNeeded()
    return vimrc#bin#tmux#isAvailable() && vimrc#bin#tmux#isWorkingUnder()
endfunction
