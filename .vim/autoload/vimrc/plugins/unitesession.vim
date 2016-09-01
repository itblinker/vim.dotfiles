function vimrc#plugins#unitesession#PostSourceSetup()
    call s:settings()
endfunction


function s:settings()
    let g:unite_source_session_enable_auto_save = 1
endfunction
