function! s:settings()
    let g:rbpt_colorpairs = [
                \ ['brown',       'RoyalBlue3'],
                \ ['darkgreen',   'firebrick3'],
                \ ['darkcyan',    'RoyalBlue3'],
                \ ['darkmagenta', 'DarkOrchid3'],
                \ ['brown',       'firebrick3'],
                \ ['gray',        'RoyalBlue3'],
                \ ['darkmagenta', 'DarkOrchid3'],
                \ ['Darkblue',    'firebrick3'],
                \ ['darkcyan',    'SeaGreen3'],
                \ ['red',         'firebrick3']
                \ ]

    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0
endfunction

function! RainbowParenthesisSettingsForCandCpp()
    execute "RainbowParenthesesActivate"

    execute "RainbowParenthesesLoadRound"
    execute "RainbowParenthesesLoadSquare"
    execute "RainbowParenthesesLoadBraces"
endfunction


function! plugins#rainbowParenthesis#PostSourceSetup()
    call s:settings()
    call vimrc#utils#autocmd#filetype(['c', 'cpp'], 'RainbowParenthesisSettingsForCandCpp')
endfunction
