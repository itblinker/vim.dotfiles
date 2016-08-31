function vimrc#plugins#uniteTags#PostSourceSetup()
    call s:settings()
endfunction


function s:settings()
    let g:unite_source_tag_show_location = 0

    let g:unite_source_tag_max_name_length = 50
    let g:unite_source_tag_max_fname_length = 100
endfunction
