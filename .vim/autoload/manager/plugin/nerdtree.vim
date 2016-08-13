function s:settings()
    let g:NERDTreeHighlightCursorline = 1
    let g:NERDTreeBookmarksFile = "./.cache/nerdtree-bookmarks.vim"
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeQuitOnOpen = 1
endfunction

function s:mappings()
    nnoremap <leader>N :NERDTreeCWD<CR>'
    nnoremap <leader>T :NERDTreeFind<CR>'

    let g:NERDTreeMapOpenSplit='s'
    let g:NERDTreeMapOpenVSplit='S'
endfunction


function manager#plugin#nerdtree#Setup()
    call s:settings()
    call s:mappings()
endfunction
