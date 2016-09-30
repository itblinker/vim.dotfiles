function! plugins#rainbowParenthesis#PostSourceSetup()
    call s:settings()
    call s:turn_on_c_and_cpp()
endfunction


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


function! s:turn_on_c_and_cpp()
    augroup aucmd_rainbow_parenthesis_c_and_cpp
        autocmd!
        autocmd Syntax cpp call s:settings_c_languages()
        autocmd Syntax c call s:settings_c_languages()
    augroup END
endfunction


function! s:settings_c_languages()
    execute "RainbowParenthesesActivate"

    execute "RainbowParenthesesLoadRound"
    execute "RainbowParenthesesLoadSquare"
    execute "RainbowParenthesesLoadBraces"
endfunction
