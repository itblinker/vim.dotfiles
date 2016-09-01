function! vimrc#plugins#vimbookmarks#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:bookmark_auto_save = 1
    let g:bookmark_auto_save_file = vimrc#getCacheDir().'/bookmarks'

    let g:bookmark_center = 1
    let g:bookmark_auto_close = 0
endfunction


function! s:mappings()
    let g:bookmark_no_default_key_mappings = 1

    noremap mt :BookmarkToggle<CR>
    noremap mn :BookmarkAnnotate<CR>
    noremap mca :BookmarkClear<CR>

    nnoremap <leader>m :Unite vim_bookmarks<CR>
endfunction
