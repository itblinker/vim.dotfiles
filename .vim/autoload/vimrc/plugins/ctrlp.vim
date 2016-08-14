function manager#plugin#ctrlp#Settings()
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_by_filename = 0

    let g:ctrlp_working_path_mode = 'w' "start search from :pwd
    let g:ctrlp_open_multiple_files = 'i'
    let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:50'
    let g:ctrlp_tabpage_position = 'al' "open (a)fter (l)ast one

    let g:ctrlp_extensions = ['switcher']

    if executable('ag')"{{{
        let s:ag_options = '--smart-case'
        let s:ag_ignore_dir = ['.svn', '.git', '.hg']

        " hidden files
        if g:ctrlp_show_hidden == 1
            let s:ag_options = s:ag_options.' --hidden'
        endif

        "ignore directories
        let s:ag_cumulative_ignore = ''
        if len(s:ag_ignore_dir) > 0
            for item in s:ag_ignore_dir
                let s:ag_cumulative_ignore = s:ag_cumulative_ignore.'--ignore-dir='.item.' '
            endfor
        endif

        "applying
        let g:ctrlp_user_command = 'ag %s -l '.s:ag_options.' '.s:ag_cumulative_ignore.'-g ""'
    endif"}}}
endfunction

function manager#plugin#ctrlp#Mappings()
endfunction
