function manager#plugin#airline#Settings()
    let g:airline_theme='base16_summerfruit'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_tabs = 0
    let g:airline#extensions#tabline#show_buffer = 0
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#show_tab_nr = 0	"disable tab number
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'

    let g:airline#extensions#branch#enabled = 1

    let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
    let g:airline#extensions#quickfix#location_text = 'LocationList'

    let g:airline#extensions#bufferline#enabled = 0
    let g:airline#extensions#bufferline#overwrite_variables = 0
endfunction

function manager#plugin#airline#Mappings()
endfunction
