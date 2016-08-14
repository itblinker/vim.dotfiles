function s:settings()
    let l:local_wiki = manager#vim#GeCwdVimStore().'/wiki'
    let g:vimwiki_list = [
                \ {'path': '~/Dropbox/Notes/vimwiki'},
                \ {'path': l:local_wiki}
                \ ]

    let g:vimwiki_dir_link = 'index'
    let g:vimwiki_hl_headers = 1
    let g:vimwiki_hl_cb_checked = 2
endfunction


function s:bufferMappings()
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
    let g:vimwiki_map_prefix = '<Leader>v'

    nmap <Leader>vw <Plug>VimwikiIndex
    nmap <Leader>vs <Plug>VimwikiUISelect
    nmap <Leader>vd <Plug>VimwikiDiaryIndex

    call s:bufferMappings()
endfunction


function manager#plugin#vimwiki#Setup()
    call s:settings()
    call s:mappings()
endfunction
