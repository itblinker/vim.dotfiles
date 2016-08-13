function s:settings()
    let g:cpp_class_scope_highlight = 1
    let g:cpp_experimental_template_highlight = 1
    let g:cpp_no_curly_error = 1
endfunction


function manager#plugin#cppenhancedhighlits#Setup()
   call s:settings()
endfunction
