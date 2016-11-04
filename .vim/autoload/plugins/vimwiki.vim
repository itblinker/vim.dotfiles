function! s:settings()
    let g:vimwiki_list = [ plugins#vimwiki#dropbox#getConfiguration() ]
endfunction


function! LaunchVimWiki()
    try
        if !vimrc#bin#dropbox#isAvailable()
            echomsg 'vimwiki: dropbox cannot be found by vim'
        endif

        execute '$tabnew | VimwikiIndex'
    catch
        echomsg 'some fucking problem you have got dude'
    endtry
endfunction


function s:globalMappings()
    nnoremap <leader><leader>w :call LaunchVimWiki()<CR>
endfunction


function! MappingsForVimWikiBuffer()
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


function! s:localMappings()
    call vimrc#utils#autocmd#filetype(['vimwiki'], 'MappingsForVimWikiBuffer')
endfunction


function! s:mappings()
    call s:globalMappings()
    call s:localMappings()
endfunction


function! plugins#vimwiki#PreSourceSetup()
    let g:vimwiki_map_prefix = '<Leader><Leader><Leader>'
endfunction


function! plugins#vimwiki#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction
