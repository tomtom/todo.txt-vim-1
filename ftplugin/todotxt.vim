" CopyTag: Searches for tags in todo.txt files
" Author: Graham Davies <graham@grahamdavies.net>
"         Tom Link (mailto:micathom AT gmail com?subject=[vim])


command! -buffer -nargs=0 -bar CopyTag :call todotxt#CopyTag()
command! -buffer -nargs=0 -bar CopyDate :call todotxt#CopyDate()
command! -buffer -nargs=1 DueDate :call todotxt#DueDate(<f-args>)
command! -buffer -nargs=0 MarkDue :call todotxt#MarkDue()
command! -buffer -nargs=? TodoDone :call todotxt#TodoDone(<f-args>)
command! -buffer -nargs=? TodoCancelled :call todotxt#TodoCancelled(<f-args>)
command! -buffer -nargs=? -bar TodoFold call todotxt#Fold(empty(<q-args>) ? getline('.') : <q-args>)


" Add a tag
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'t') '$:CopyTag<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'t') '$:CopyTag<CR>'

" Mark a task as done
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'x') ':TodoDone<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'x') ':TodoDone<CR>'

exec 'nnoremap <buffer>' (g:todotxt_mapleader .'c') ':TodoCancelled<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'c') ':TodoCancelled<CR>'

exec 'nnoremap <buffer>' (g:todotxt_mapleader .'j') '$:CopyTag<CR>:CopyDate<CR>:TodoDone<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'j') '$:CopyTag<CR>:CopyDate<CR>::TodoDone<CR>'

" Clear away indented done lines
" exec 'nnoremap <buffer>' (g:todotxt_mapleader .'c') 'kmrj/^\s\+x <CR>ddGp:s/^\s\+//<CR>''r:nohlsearch<CR>'

" Other macros
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'d') ':<C-U>exec "DueDate" v:count1<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'d') ':<C-U>exec "DueDate" v:count1<CR>'
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'w') ':DueDate 7<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'w') ':DueDate 7<CR>'
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'m') ':DueDate 30<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'m') ':DueDate 30<CR>'
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'s') ':%sort u<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'s') ':%sort u<CR>'
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'r') 'zRmr:%sort! u<CR>''r'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'r') 'zRmr:%sort! u<CR>''r'

" abbreviations
" can put these in .vimrc if useful for other file types
iab <buffer> ddate <c-r>=strftime(g:todotxt#date_ymd)<cr>
iab <buffer> xdate <c-r>=strftime(g:todotxt#date_ymd ." %H:%M")<cr>
iab <buffer> tdate <c-r>=strftime(g:todotxt#date_md)<cr>
"iab <buffer> 7date <c-r>=strftime("(%m/%d)", localtime() + 3600*24*7)<cr>
"iab <buffer> 1date <c-r>=strftime("(%m/%d)", localtime() + 3600*24*1)<cr>
"iab <buffer> 2date <c-r>=strftime("(%m/%d)", localtime() + 3600*24*2)<cr>

iab <buffer> 1days   <c-r>=substitute(system('date --date="+ 1 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 2days   <c-r>=substitute(system('date --date="+ 2 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 3days   <c-r>=substitute(system('date --date="+ 3 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 4days   <c-r>=substitute(system('date --date="+ 4 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 5days   <c-r>=substitute(system('date --date="+ 5 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 6days   <c-r>=substitute(system('date --date="+ 6 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 7days   <c-r>=substitute(system('date --date="+ 7 days"            +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> nmon    <c-r>=substitute(system('date --date="next monday"         +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> ntue    <c-r>=substitute(system('date --date="week tuesday"        +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> nwed    <c-r>=substitute(system('date --date="week wednesday"      +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> eotw    <c-r>=substitute(system('date --date="next friday"         +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> eonw    <c-r>=substitute(system('date --date="week friday"         +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 2weeks  <c-r>=substitute(system('date --date="+ 14 days"           +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 3weeks  <c-r>=substitute(system('date --date="+ 21 days"           +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 2months <c-r>=substitute(system('date --date="+ 60 days"           +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> 3months <c-r>=substitute(system('date --date="+ 90 days"           +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> eotm    <c-r>=substitute(system('date --date="next month - 1 day"  +'. escape(g:todotxt#date_md, '()')),"\\n","","")<cr>
iab <buffer> eoty    <c-r>=substitute(system('date --date="next year"           +'. escape(g:todotxt#date_ymd, '()')),"\\n","","")<cr>


