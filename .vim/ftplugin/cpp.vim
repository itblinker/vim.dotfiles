setlocal colorcolumn=120

setlocal tabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab

setloca nowrap

"execute 'nnoremap <buffer> <C-]> :Unite '.manager#plugin#unite#GetPreviewCommonSubSettings().' -immediately gtags/def<CR>'
"execute 'nnoremap <buffer> <leader>gr :Unite '.manager#plugin#unite#GetPreviewCommonSubSettings().' gtags/ref<CR>'
"execute 'nnoremap <buffer> <leader>gr :Unite '.manager#plugin#unite#GetPreviewCommonSubSettings().manager#plugin#unite#GtagNoDeclarationsInput()' gtags/ref<CR>'
"execute 'nnoremap <buffer> <leader>gi :Unite '.manager#plugin#unite#GetPreviewCommonSubSettings().manager#plugin#unite#GtagInheritanceInput().' gtags/ref<CR>'
"execute 'nnoremap <buffer> <leader>gc :Unite '.manager#plugin#unite#GetPreviewCommonSubSettings().' gtags/context<CR>'
"execute 'nnoremap <buffer> <leader>gG :Unite '.manager#plugin#unite#GetPreviewCommonSubSettings().' gtags/grep:<CR>'
