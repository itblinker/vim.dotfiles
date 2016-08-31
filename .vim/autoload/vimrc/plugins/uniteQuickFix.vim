function vimrc#plugins#uniteQuickFix#PostSourceSetup()
    call s:mappings()
endfunction


function s:mappings()
    "execute 'nnoremap <leader>q :Unite -smartcase '.manager#plugin#unite#GetPreviewCommonSubSettings().' quickfix<CR>'
    "execute 'nnoremap <leader>l :Unite -smartcase '.manager#plugin#unite#GetPreviewCommonSubSettings().' location_list<CR>'
endfunction

