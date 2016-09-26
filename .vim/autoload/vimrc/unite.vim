function! vimrc#unite#PostSourceSetup()
"{{{
    call s:settings()
    call s:mappings()
endfunction


function! s:settings()
    call s:paths()
    call s:setupDefaultProfile()
    call s:cachingRecursiveFiles()
    call s:asyncCommandsSettings()
    call s:find()
    call s:grep()
endfunction


function! s:setupDefaultProfile()
    call unite#custom#profile('default', 'context',
                \ {
                \ 'start_insert' : 0,
                \ 'smart_case' : 1,
                \ 'prompt' : '>>',
                \ 'prompt_focus' : 1,
                \ 'prompt_direction' : 'top',
                \ 'auto_preview' : 0,
                \ 'horizontal' : 1,
                \ 'winheight' : '15',
                \ 'previewheight' : '15',
                \ 'truncate' : '0'
                \ })
    call unite#filters#matcher_default#use(['matcher_regexp'])
endfunction


function! s:paths()
    let g:unite_data_directory = vimrc#getCacheDir().'/unite'
endfunction


function! s:cachingRecursiveFiles()
    let g:unite_source_rec_min_cache_files = 100
    let g:unite_source_rec_max_cache_files = 20000
endfunction


function! s:asyncCommandsSettings()
    if executable('ag')
        let g:unite_source_rec_async_command =
                    \ ['ag', '--follow', '--nocolor', '--nogroup',
                    \  '--hidden', '-g', '']
    elseif executable('ack')
        let g:unite_source_rec_async_command =
                    \ ['ag', '--follow', '--nocolor', '--nogroup',
                    \  '--hidden', '-g', '']
    endif
endfunction


function! s:find()
    let g:unite_source_find_default_expr = '-iname '
endfunction


function! s:grep()
    let g:unite_source_grep_default_opts =
                \ '-iRHn --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.bzr'

    let g:unite_source_grep_recursive_opt = ''

    let g:unite_source_grep_search_word_highlight = 'None'

    if executable('ag')
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
                    \ '-i --vimgrep --hidden --ignore ' .
                    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_recursive_opt = ''
    endif
endfunction


function! s:mappings()
    call s:globalMappings()

	augroup uniteBufferSpecific
	    autocmd!
	    autocmd FileType unite call s:uniteBufferMappings()
    augroup END

endfunction


function! s:globalMappings()
    let g:unite_no_default_keymappings = 1

    nnoremap <leader>ru :UniteResume -smartcase<CR>

    nnoremap <leader>w :Unite window<CR>
    nnoremap <leader>t :Unite tab<CR>

    nnoremap <leader>sa :Unite file_rec/async:!<CR>

    call unite#custom#source('file_rec/async',
                \ 'matchers', ['converter_file_directory', 'matcher_regexp'])

    nnoremap <leader>bf  :Unite buffer:-<CR>
    nnoremap <leader>ba  :Unite buffer<CR>

    call unite#custom#source('buffer_tab,buffer',
                \ 'matchers', ['converter_file_directory', 'matcher_regexp'])

    nnoremap <leader>p :Unite jump<CR>
    nnoremap <leader>e :Unite change<CR>

    "execute 'nnoremap <leader>ss :call manager#plugin#unite#FindSimiliarFilesByUnite()<CR>'
    "execute 'nnoremap <leader>sf :call manager#plugin#unite#FindSourceOrHeaderFileByUnite()<CR>'
    "execute 'nnoremap <leader>GW :call manager#plugin#unite#GrepByUnite()<CR>'
endfunction


function! s:uniteBufferMappings()
    setlocal number
    setlocal relativenumber

    nmap <buffer> q <Plug>(unite_exit)
    nmap <buffer> Q <Plug>(unite_all_exit)

    nmap <buffer> <Space> <Plug>(unite_toggle_mark_current_candidate)
    nmap <buffer> * <Plug>(unite_toggle_mark_all_candidates)

    nmap <buffer> <Tab> <Plug>(unite_choose_action)
    imap <buffer> <Tab> <Plug>(unite_choose_action)

    nmap <buffer> <CR> <Plug>(unite_do_default_action)
    imap <buffer> <CR> <Plug>(unite_do_default_action)

    nmap <buffer> r <Plug>(unite_redraw)

    nmap <buffer> i <Plug>(unite_insert_enter)
    nmap <buffer> I <Plug>(unite_insert_head)
    nmap <buffer> a <Plug>(unite_append_enter)
    nmap <buffer> A <Plug>(unite_append_end)
    nmap <buffer> gg <Plug>(unite_cursor_top)
    nmap <buffer> G <Plug>(unite_cursor_bottom)
    nmap <buffer> <leader>p <Plug>(unite_smart_preview)
    nmap <buffer> ? <Plug>(unite_quick_help)
    nmap <buffer> M <Plug>(unite_disable_max_candidates)
    imap <buffer> <C-f> <Plug>(unite_select_next_page)
    imap <buffer> <C-b> <Plug>(unite_select_previous_page)

    nnoremap <silent><buffer><expr> o unite#smart_map('o', unite#do_action('open'))
    nnoremap <silent><buffer><expr> d unite#smart_map('d', unite#do_action('delete'))
    nnoremap <silent><buffer><expr> t unite#smart_map('t', unite#do_action('tabopen'))
    nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
    nnoremap <silent><buffer><expr> S unite#smart_map('S', unite#do_action('vsplit'))
    nnoremap <silent><buffer><expr> p unite#smart_map('p', unite#do_action('append'))
    nnoremap <silent><buffer><expr> P unite#smart_map('P', unite#do_action('insert'))
endfunction
"}}}


function! vimrc#unite#Grep(...)
"{{{
    if a:0 == 1
        execute 'Unite '.s:getGrepSource(escape(a:1, '\[]%'), getcwd())
    elseif a:0 == 2
        execute 'Unite '.s:getGrepSource(escape(a:1, '\[]%'), a:2)
    else
        echomsg 'vimrc#plugins#unite#Grep expects max 2 arguments | skipped'
    endif
endfunction


function! s:getGrepSource(string, path)
    let s:cache = g:unite_source_grep_default_opts
    let g:unite_source_grep_default_opts =
                \ '-rHn --exclude-dir=.*git --exclude-dir=.svn --exclude-dir=.bzr --exclude-dir='

    try
        return 'grep:'.a:path.'::'.a:string
    catch
        let g:unite_source_grep_default_opts = s:cache
        throw v:exception
    finally
        let g:unite_source_grep_default_opts = s:cache
    endtry
endfunction

"}}}
