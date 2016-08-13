function s:settings()
    let g:qfenter_enable_autoquickfix = 0

    let g:qfenter_keep_quickfixfocus = {
                \'open':  0,
                \'cnext': 0,
                \'cprev': 0,
                \}
endfunction

function s:mappings()
    let g:qfenter_open_map = ['o']
    let g:qfenter_vopen_map = ['S']
    let g:qfenter_hopen_map = ['s']
    let g:qfenter_topen_map = ['t']
endfunction


function manager#plugin#qfenter#Setup()
    call s:settings()
    call s:mappings()
endfunction

