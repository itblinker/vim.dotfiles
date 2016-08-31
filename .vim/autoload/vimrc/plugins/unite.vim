function vimrc#plugins#unite#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function s:settings()
    "call s:defaultProfile()
    call s:matching()
    call s:paths()
    call s:caching()
    call s:find()
    call s:grep()
    call s:yank()
endfunction


"function s:defaultProfile()
	"call unite#custom#profile('default', 'context',
                "\ {
				"\ 'start_insert': 0
				"\ })

"endfunction

function s:matching()
    call unite#filters#matcher_default#use(['matcher_glob'])
    call unite#filters#sorter_default#use(['sorter_rank'])

    let g:unite_enable_auto_select = 0
    let g:unite_prompt = '>> '
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

    nnoremap <leader>u :Unite -smartcase -start-insert -wipe<CR>
    nnoremap <leader>ru :UniteResume -smartcase<CR>
    nnoremap <leader>rg :UniteResume 'grep'<CR>
    nnoremap <leader>rf :UniteResume 'find'<CR>

    nnoremap <leader>w :Unite -smartcase -wipe window<CR>
    nnoremap <leader>t :Unite -smartcase -wipe tab<CR>

    nnoremap <leader>sa :Unite -smartcase -start-insert -wipe file_rec/async:!<CR>
    execute 'nnoremap <leader>sm :call manager#plugin#unite#MruSourcesinCwd()<CR>'

    nnoremap <leader>bb  :Unite -smartcase -start-insert -wipe buffer_tab:-<CR>
    nnoremap <leader>bf  :Unite -smartcase -start-insert -wipe buffer:-<CR>
    nnoremap <leader>ba  :Unite -smartcase -start-insert -wipe buffer<CR>

    nnoremap <leader>p :Unite -smartcase -start-insert -wipe jump<CR>
    nnoremap <leader>e :Unite -smartcase -start-insert -wipe change<CR>
    nnoremap <leader>m :Unite -smartcase -start-insert -wipe mark vim_bookmarks<CR>

    nnoremap <leader>c :Unite -smartcase -start-insert -wipe history/command<CR>
    nnoremap <leader>y :Unite -smartcase -start-insert -wipe history/yank<CR>

    execute 'nnoremap <leader>ss :call manager#plugin#unite#FindSimiliarFilesByUnite()<CR>'
    execute 'nnoremap <leader>sf :call manager#plugin#unite#FindSourceOrHeaderFileByUnite()<CR>'
    execute 'nnoremap <leader>GW :call manager#plugin#unite#GrepByUnite()<CR>'
endfunction
