function! plugins#vimwiki#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction

function! s:getWimWikiLIst()
"{{{
    if !vimrc#isDropboxAvailable()
        return [s:getLocalWiki()]
    else
        return [
             \ s:getLocalWiki(),
             \ {'path': vimrc#getDropboxDirPath().'/wiki',
             \  'path_html' : vimrc#getDropboxDirPath().'/wiki_html'}
             \ ]

    endif
endfunction

function! s:getLocalWiki()
    let l:cwd_wiki = vimrc#getCacheDir().'/wiki'
    let l:cwd_wiki_html = l:cwd_wiki.'_html'

    return {'path': l:cwd_wiki, 'path_html' : l:cwd_wiki_html.'_html'}
endfunction
"}}}

function! s:settings()
    let g:vimwiki_list = s:getWimWikiLIst()

    let g:vimwiki_dir_link = 'index'
    let g:vimwiki_hl_headers = 1
    let g:vimwiki_hl_cb_checked = 2
endfunction


function! s:bufferMappings()
    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vgH <Plug>Vimwiki2HTML

    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vs <Plug>VimwikiSplitLink
    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vS <Plug>VimwikiVSplitLink
    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vo <Plug>VimwikiFollowLink
    autocmd FileType vimwiki nmap <silent><buffer> <Leader>v< <Plug>VimwikiGoBackLink

    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vn <Plug>VimwikiNextLink
    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vN <Plug>VimwikiPrevLink

    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vD <Plug>VimwikiDeleteLink
    autocmd FileType vimwiki nmap <silent><buffer> <Leader>vR <Plug>VimwikiRenameLink

    autocmd FileType vimwiki nmap <silent><buffer> <leader>vO :VimwikiGoto
    autocmd FileType vimwiki nmap <silent><buffer> <leader>vF :VimwikiSearch /
    autocmd FileType vimwiki nmap <silent><buffer> <leader>vB :VimwikiBacklinks<CR>
endfunction


function s:mappings()
    nnoremap tlv <Plug>1VimwikiTabIndex
    nnoremap tgv <Plug>2VimwikiTabIndex

    call s:bufferMappings()
endfunction



