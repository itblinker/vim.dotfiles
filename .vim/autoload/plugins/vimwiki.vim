function! plugins#vimwiki#PreSourceSetup()
    let g:vimwiki_map_prefix = '<Leader><Leader><Leader>'
endfunction


function! plugins#vimwiki#PostSourceSetup()
    call s:settings()
    call s:commands()
    call s:mappings()
endfunction

function! s:getWimWikiLIst()
"{{{
    if !vimrc#isDropboxAvailable()
        return [s:getLocalWiki()]
    else
        return [
             \ s:getLocalWiki(),
             \ s:getDropboxWiki()
             \ ]
    endif
endfunction

function! s:getLocalWiki()
    let l:cwd_wiki = vimrc#getCacheDir().'/wiki'
    let l:cwd_wiki_html = vimrc#getCacheDir().'/wiki_html'

    return {
           \ 'path': l:cwd_wiki,
           \ 'path_html' : cwd_wiki_html,
           \ 'diary_rel_path' : 'diary/',
           \ 'auto_tags': 1,
           \ 'auto_export' : 0,
           \ 'auto_toc' : 1,
           \ 'index' : 'index',
           \ 'ext' : '.wiki',
           \ 'syntax': 'default'
           \ }
endfunction


function! s:getDropboxWiki()
    let l:dropbox_wiki = vimrc#getDropboxDirPath().'/wiki'
    let l:dropbox_wiki_html = vimrc#getDropboxDirPath().'/wiki_html'

    return {
           \ 'path': l:dropbox_wiki,
           \ 'path_html' : dropbox_wiki_html,
           \ 'diary_rel_path' : 'diary/',
           \ 'auto_tags': 1,
           \ 'auto_export' : 0,
           \ 'auto_toc' : 1,
           \ 'index' : 'index',
           \ 'ext' : '.wiki',
           \ 'syntax': 'default'
           \ }
endfunction

"}}}

function! s:settings()
    let g:vimwiki_list = s:getWimWikiLIst()
endfunction


function! s:vimwiki_buffer_mappings()
    nmap <C-]> <Plug>VimwikiFollowLink
    nmap <C-t> <Plug>VimwikiGoBackLink
endfunction


function! s:mappings()

    nnoremap <leader><leader>w :VimwikiUISelect<CR>
    nnoremap <leader><leader>l :1VimwikiTabIndex<CR>
    nnoremap <leader><leader>g :2VimwikiTabIndex<CR>

    augroup vimwiki_autocmds
        autocmd!
        autocmd Filetype vimwiki call s:vimwiki_buffer_mappings()
    augroup END

endfunction


function! s:commands()

endfunction



