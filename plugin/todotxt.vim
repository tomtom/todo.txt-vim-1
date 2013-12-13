" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @GIT:         https://github.com/tomtom/todo.txt-vim-1
" @Revision:    9
" 

if &cp || exists("loaded_todo")
    finish
endif
let loaded_todo = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:todotxt_mapleader')
    let g:todotxt_mapleader = '<localleader>t'   "{{{2
endif


command! -bar -bang -nargs=? Todotxt call todotxt#Open(empty("<bang>") ? <q-args> : get(g:todotxt#files, 0, ''))


let &cpo = s:save_cpo
unlet s:save_cpo
