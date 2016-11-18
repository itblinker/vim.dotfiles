" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not mofidify the code nor insert new lines before '" ___vital___'
if v:version > 703 || v:version == 703 && has('patch1170')
  function! vital#_vimrc#System#Cache#Base#import() abort
    return map({'_vital_depends': '', 'new': '', '_vital_loaded': ''},  'function("s:" . v:key)')
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  execute join(['function! vital#_vimrc#System#Cache#Base#import() abort', printf("return map({'_vital_depends': '', 'new': '', '_vital_loaded': ''}, \"function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
  delfunction s:_SID
endif
" ___vital___
let s:save_cpo = &cpo
set cpo&vim

function! s:_vital_loaded(V) abort
  let s:Prelude = a:V.import('Prelude')
endfunction
function! s:_vital_depends() abort
  return ['Prelude']
endfunction

let s:cache = {
      \ '__name__': 'base',
      \}
function! s:new(...) abort
  return deepcopy(s:cache)
endfunction
function! s:cache.cache_key(obj) abort
  let cache_key = s:Prelude.is_string(a:obj) ? a:obj : string(a:obj)
  return cache_key
endfunction
function! s:cache.has(name) abort
  throw 'vital: System.Cache.Base: has({name}) is not implemented'
endfunction
function! s:cache.get(name, ...) abort
  throw 'vital: System.Cache.Base: get({name}[, {default}]) is not implemented'
endfunction
function! s:cache.set(name, value) abort
  throw 'vital: System.Cache.Base: set({name}, {value}[, {default}]) is not implemented'
endfunction
function! s:cache.keys() abort
  throw 'vital: System.Cache.Base: keys() is not implemented'
endfunction
function! s:cache.remove(name) abort
  throw 'vital: System.Cache.Base: remove({name}) is not implemented'
endfunction
function! s:cache.clear() abort
  throw 'vital: System.Cache.Base: clear() is not implemented'
endfunction
function! s:cache.on_changed() abort
  " A user defined hook function
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
"vim: sts=2 sw=2 smarttab et ai textwidth=0 fdm=marker
