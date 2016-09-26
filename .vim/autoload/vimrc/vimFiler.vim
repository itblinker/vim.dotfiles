function vimrc#vimFiler#PostSourceSetup()
    call s:settings()
    call s:mappings()
endfunction


function s:mappings()
    nnoremap <leader>N :VimFilerCurrentDir<CR>
    nnoremap <leader>T :VimFilerBufferDir -find<CR>
endfunction


function s:vimFilerBufferMappings()
endfunction

function s:settings()
	let g:vimfiler_as_default_explorer = 1
	let g:vimfiler_safe_mode_by_default = 0
    let g:vimfiler_data_directory = vimrc#getCacheDir().'/vimFiler'
endfunction
