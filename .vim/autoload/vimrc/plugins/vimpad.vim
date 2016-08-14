function s:settigns()
    let g:pad#default_format = 'txt'
    let g:pad#dir = '~/Dropbox/Notes/vimpad'
    let g:pad#local_dir = 'notes'

    let g:pad#rename_files = 1
    let g:pad#title_first_line = 1

    let g:pad#window_height = 10
    let g:pad#window_width = 40
    let g:pad#position = { "list" : "bottom", "pads": "bottom" }
    let g:pad#open_in_split = 1

    let g:pad#search_backend = "grep"
    let g:pad#search_ignorecase = 1
    let g:pad#query_filenames = 1
    let g:pad#query_dirnames = 1

    let g:pad#read_nchars_from_files = 200
    let g:pad#highlighting_variant = 0
    let g:pad#highlight_query = 1
    let g:pad#jumpto_query = 1
    let g:pad#show_dir = 1
endfunction


function s:mappings()
    let g:pad#set_mappings = 1
    let g:pad#maps#list = "<leader>nl"
    let g:pad#maps#new = "<leader>nn"
    let g:pad#maps#search = "<leader>ns"
endfunction



function manager#plugin#vimpad#Setup()
    call s:settigns()
    call s:mappings()
endfunction

