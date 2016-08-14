function manager#plugin#ctrlptjump#Settings()
    let g:ctrlp_tjump_shortener = ['/home/.*/gems/', '.../']
    let g:ctrlp_tjump_only_silent = 1
    let g:ctrlp_tjump_skip_tag_name = 1
endfunction

function manager#plugin#ctrlptjump#Mappings()
    nnoremap <c-]> :CtrlPtjump<cr>
    noremap <c-]> :CtrlPtjumpVisual<cr>
endfunction
