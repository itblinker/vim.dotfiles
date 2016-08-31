function vimrc#plugins#uniteGtags#PostSourceSetup()
    call s:settings()
endfunction


function s:settings()
    let g:unite_source_gtags_project_config = {
                \ '_': { 'treelize': 1, 'uniteSource__Gtags_LineNr': 0, 'uniteSource__Gtags_Path': 0 }
                \ }
endfunction
