function vimrc#plugins#unite#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function s:settings()
    call s:setupDefaultProfile()
    call s:paths()
    call s:caching()
    call s:find()
    call s:grep()
    call s:yank()
endfunction


function s:setupDefaultProfile()

    call unite#custom#profile('default', 'context',
                \ {
                \ 'start_insert' : 0,
                \ 'smart_case' : 1,
                \ 'prompt' : '>>',
                \ 'prompt_focus' : 0,
                \ 'prompt_direction' : 'top',
                \ 'auto_preview' : 0,
                \ 'horizontal' : 1,
                \ 'winheight' : '15',
                \ 'previewheight' : '15',
                \ 'truncate' : '0'
                \ })

    call unite#custom#source('file_rec/async,buffer_tab,buffer',
                \ 'matchers', ['converter_file_directory', 'matcher_regexp'])
    call unite#custom#source('buffer_tab', 'matchers', ['converter_file_directory', 'matcher_regexp'])

endfunction


function s:paths()
    "let g:unite_data_directory = g:vim_manager_home_dir.'/unite'
endfunction


function s:caching()
    let g:unite_source_rec_min_cache_files = 100
    let g:unite_source_rec_max_cache_files = 0
endfunction


function s:find()
    let g:unite_source_find_default_expr = '-iname '
endfunction


function s:grep()
    let g:unite_source_grep_default_opts = '-inH --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.bzr'
    let g:unite_source_grep_search_word_highlight = 'None'

    if executable('ag')
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
                    \ '-i --vimgrep --hidden --ignore ' .
                    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_recursive_opt = ''
    endif
endfunction


function s:yank()
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_yank_history_save_clipboard = 1
endfunction


function s:mappings()
    let g:unite_no_default_keymappings = 1

    nnoremap <leader>ru :UniteResume -smartcase<CR>

    nnoremap <leader>w :Unite window<CR>
    nnoremap <leader>t :Unite tab<CR>

    nnoremap <leader>sa :Unite file_rec/async:!<CR>

    nnoremap <leader>bf  :Unite buffer:-<CR>
    nnoremap <leader>ba  :Unite buffer<CR>

    nnoremap <leader>p :Unite jump<CR>
    nnoremap <leader>e :Unite change<CR>

    nnoremap <leader>c :Unite history/command<CR>

    "execute 'nnoremap <leader>sm :call manager#plugin#unite#MruSourcesinCwd()<CR>'
    "execute 'nnoremap <leader>ss :call manager#plugin#unite#FindSimiliarFilesByUnite()<CR>'
    "execute 'nnoremap <leader>sf :call manager#plugin#unite#FindSourceOrHeaderFileByUnite()<CR>'
    "execute 'nnoremap <leader>GW :call manager#plugin#unite#GrepByUnite()<CR>'
endfunction
