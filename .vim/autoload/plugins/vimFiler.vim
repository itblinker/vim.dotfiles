function! plugins#vimFiler#PreSourceSetup()
    let g:vimfiler_no_default_key_mappings = 1
endfunction


function! plugins#vimFiler#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function! s:mappings()
    call s:globalMappings()

    augroup vimfilerBufferSpecific
        autocmd!
        autocmd FileType vimfiler call s:vimfilerBufferMappings()
    augroup END
endfunction


function! s:globalMappings()
    nnoremap <leader>N :VimFilerCurrentDir<CR>
    nnoremap <leader>T :VimFilerBufferDir -find<CR>
endfunction


function! s:vimfilerBufferMappings()
    nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
    nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
    nmap <buffer> h <Plug>(vimfiler_smart_h)
    nmap <buffer> l <Plug>(vimfiler_expand_or_edit)

    nmap <buffer> o <Plug>(vimfiler_cd_or_edit)
    nmap <buffer> <leader>o <Plug>(vimfiler_select_sort_type)
    nmap <buffer> O <Plug>(vimfiler_expand_tree)

    nmap <buffer> ~ <Plug>(vimfiler_switch_to_home_directory)
    nmap <buffer> \ <Plug>(vimfiler_switch_to_root_directory)
    nmap <buffer> & <Plug>(vimfiler_switch_to_project_directory)

    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    nmap <buffer> <leader>R <Plug>(vimfiler_redraw_screen)

    nmap <buffer> <leader>p <Plug>(vimfiler_preview_file)

    nmap <buffer> <Tab> <Plug>(vimfiler_choose_action)

    nmap <buffer> gj <Plug>(vimfiler_jump_last_child)
    nmap <buffer> gk <Plug>(vimfiler_jump_first_child)

    nmap <buffer> <leader>s <Plug>(vimfiler_popup_shell)

    nnoremap <silent><buffer><expr> S vimfiler#do_switch_action('vsplit')
    nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')

    nmap <buffer> dd <Plug>(vimfiler_delete_file)
    nmap <buffer> yy <Plug>(vimfiler_yank_full_path)

    nmap <buffer> mf <Plug>(vimfiler_new_file)
    nmap <buffer> md <Plug>(vimfiler_make_directory)

    nmap <buffer> <C-g> <Plug>(vimfiler_print_filename)

    nmap <buffer> <Space> <Plug>(vimfiler_toggle_mark_current_line)
    nmap <buffer> * <Plug>(vimfiler_toggle_mark_all_lines)
    nmap <buffer> # <Plug>(vimfiler_clear_mark_all_lines)

    nmap <buffer> q <Plug>(vimfiler_close)
    nmap <buffer> <leader>? <Plug>(vimfiler_help)
    nmap <buffer> <leader>v <Plug>(vimfiler_toggle_visible_ignore_files)
endfunction


function! s:settings()
    call s:startup()
    call s:paths()
    call s:iconSettings()
	call s:defaultProfile()
endfunction


function! s:defaultProfile()
    call vimfiler#custom#profile('default', 'context', {
        \ 'safe' : 0,
        \ 'edit_action' : 'open',
        \ 'sort-type=' : 'filename',
        \ })
endfunction

function! s:iconSettings()
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'
endfunction


function! s:startup()
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_ignore_pattern = ['^\.']

    augroup vimFilerStartup
        autocmd!
        autocmd VimEnter * if !argc() | VimFiler | endif
    augroup END
endfunction


function! s:paths()
    let g:vimfiler_data_directory = vimrc#getCacheDir().'/vimFiler'
endfunction
