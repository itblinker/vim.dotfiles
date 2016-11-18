function! plugins#nerdtree#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    let g:NERDTreeHighlightCursorline = 1
    let g:NERDTreeChDirMode = 0
    let g:NERDTreeWinPos = 'left'

    let g:NERDTreeBookmarksFile = vimrc#cache#instance().fetch().'/nerdtree-bookmarks.vim'

    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeQuitOnOpen = 1
endfunction


function! s:mappings()
    let g:NERDTreeCustomReuseWindows = '1'

    nnoremap <leader>N :NERDTreeCWD<CR>
    nnoremap <leader>T :NERDTreeFind<CR>
endfunction
