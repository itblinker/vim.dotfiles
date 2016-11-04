function! plugins#vimwiki#local#getDirectory()
    return vimrc#cache#local#getPath().'/notes.vimwiki'
endfunction


function! plugins#vimwiki#local#isAvailable()
    return isdirectory(plugins#vimwiki#local#getDirectory())
endfunction


function! plugins#vimwiki#local#getConfiguration()
    let l:wiki = plugins#vimwiki#local#getDirectory()
    let l:wiki_html = l:wiki.'_html'

    return {
           \ 'path': l:wiki,
           \ 'path_html': wiki_html,
           \ 'diary_rel_path': 'diary/',
           \ 'auto_export': 0,
           \ 'auto_toc': 1,
           \ 'auto_tag': 1,
           \ 'index': 'index',
           \ 'ext': '.wiki',
           \ 'syntax': 'default'
           \ }
endfunction
