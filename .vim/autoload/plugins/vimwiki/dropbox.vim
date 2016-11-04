let s:data =
        \ {
        \ 'dirName' : 'notes.vimwiki',
        \ 'parentPath' : vimrc#bin#dropbox#getDirectory()
        \ }


function! s:getPath()
    return s:data.parentPath.'/'.s:data.dirName
endfunction


function! plugins#vimwiki#dropbox#getConfiguration()
    let l:wiki = s:getPath()
    let l:wiki_html = s:getPath().'_html'

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
