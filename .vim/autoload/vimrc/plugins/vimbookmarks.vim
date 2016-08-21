function vimrc#plugins#vimbookmarks#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function s:settings()
    let g:bookmark_save_per_working_dir = 1
    let g:bookmark_auto_save = 1
    let g:bookmark_manage_per_buffer = 1
    let g:bookmark_center = 1
    let g:bookmark_auto_close = 0

    let g:bookmark_no_default_key_mappings = 1
endfunction

function s:mappings()
    noremap mt :BookmarkToggle<CR>
    noremap mn :BookmarkAnnotate<CR>
    noremap md :BookmarkClear<CR>
    let g:dupa_marks = 1
endfunction
