function! plugins#vimwiki#PreSourceSetup()
    let g:vimwiki_map_prefix = '<Leader><Leader><Leader>'
endfunction


function! plugins#vimwiki#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction

function! s:getWimWikiLIst()
"{{{
    if !vimrc#bin#dropbox#isDirectoryAvailable()
        return [s:getLocalWiki()]
    else
        return [
             \ s:getLocalWiki(),
             \ s:getDropboxWiki()
             \ ]
    endif
endfunction

function! s:getLocalWiki()
    let l:cwd_wiki = vimrc#cache#get().'/wiki'
    let l:cwd_wiki_html = vimrc#cache#get().'/wiki_html'

    return {
           \ 'path': l:cwd_wiki,
           \ 'path_html': cwd_wiki_html,
           \ 'diary_rel_path': 'diary/',
           \ 'auto_export': 0,
           \ 'auto_toc': 1,
           \ 'auto_tag': 1,
           \ 'index': 'index',
           \ 'ext': '.wiki',
           \ 'syntax': 'default'
           \ }
endfunction


function! s:getDropboxWiki()
    let l:dropbox_wiki = vimrc#bin#dropbox#getDirectory().'/wiki'
    let l:dropbox_wiki_html = vimrc#bin#dropbox#getDirectory().'/wiki_html'

    return {
           \ 'path': l:dropbox_wiki,
           \ 'path_html': dropbox_wiki_html,
           \ 'diary_rel_path': 'diary/',
           \ 'auto_export': 0,
           \ 'auto_toc': 1,
           \ 'auto_tag': 1,
           \ 'index': 'index',
           \ 'ext': '.wiki',
           \ 'syntax': 'default'
           \ }
endfunction

"}}}

function! s:settings()
    let g:vimwiki_list = s:getWimWikiLIst()
endfunction


function! s:vimwiki_buffer_mappings()
    nmap <buffer> <CR> <nop>

    nmap <buffer> <C-]> <Plug>VimwikiFollowLink
    nmap <buffer> <C-t> <Plug>VimwikiGoBackLink

    nmap <buffer> <leader>n <Plug>VimwikiNextLink
    nmap <buffer> <leader>N <Plug>VimwikiPrevLink

    nmap <buffer> <leader>R <Plug>VimwikiRenameLink
    nmap <buffer> <leader>D <Plug>VimwikiDeleteLink

    nmap <buffer> <leader>o :VimwikiSearch //<Left>
    nmap <buffer> <leader>O :VimwikiGoto

    nmap <buffer> <leader>H :execute 'VimwikiGoto index'<CR>
endfunction


function! s:mappings()
    nnoremap <leader><leader>w :execute "tabnew \| VimwikiUISelect"<CR>

    augroup vimwiki_autocmds
        autocmd!
        autocmd Filetype vimwiki call s:vimwiki_buffer_mappings()
    augroup END
endfunction
