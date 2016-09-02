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
