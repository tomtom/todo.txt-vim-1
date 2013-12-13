" CopyTag: Searches for tags in todo.txt files
" Author: Graham Davies <graham@grahamdavies.net>
"         Tom Link (mailto:micathom AT gmail com?subject=[vim])


command! -buffer -nargs=0 -bar CopyTag :call todotxt#CopyTag()
command! -buffer -nargs=0 -bar CopyDate :call todotxt#CopyDate()
command! -buffer -nargs=1 DueDate :call todotxt#DueDate(<f-args>)
command! -buffer -nargs=0 MarkDue :call todotxt#MarkDue()
command! -buffer -nargs=? TodoDone :call todotxt#TodoDone(<f-args>)
command! -buffer -nargs=? TodoCancelled :call todotxt#TodoCancelled(<f-args>)


" Add a tag
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'t') '$:CopyTag<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'t') '$:CopyTag<CR>'

" Mark a task as done
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'d') ':TodoDone<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'d') ':TodoDone<CR>'

exec 'nnoremap <buffer>' (g:todotxt_mapleader .'x') ':TodoCancelled<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'x') ':TodoCancelled<CR>'

exec 'nnoremap <buffer>' (g:todotxt_mapleader .'j') '$:CopyTag<CR>:CopyDate<CR>:TodoDone<CR>'
exec 'xnoremap <buffer>' (g:todotxt_mapleader .'j') '$:CopyTag<CR>:CopyDate<CR>::TodoDone<CR>'

" Clear away indented done lines
exec 'nnoremap <buffer>' (g:todotxt_mapleader .'c') 'kmrj/^\s\+x <CR>ddGp:s/^\s\+//<CR>''r:nohlsearch<CR>'

" Other macros
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
iab ddate <buffer> <c-r>=strftime("%Y-%m-%d")<cr>
iab xdate <buffer> <c-r>=strftime("%Y-%m-%d %H:%M")<cr>
iab tdate <buffer> <c-r>=strftime("(%m/%d)")<cr>
"iab 7date <buffer> <c-r>=strftime("(%m/%d)", localtime() + 3600*24*7)<cr>
"iab 1date <buffer> <c-r>=strftime("(%m/%d)", localtime() + 3600*24*1)<cr>
"iab 2date <buffer> <c-r>=strftime("(%m/%d)", localtime() + 3600*24*2)<cr>

iab 1days <buffer>   <c-r>=substitute(system('date --date="+ 1 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab 2days <buffer>   <c-r>=substitute(system('date --date="+ 2 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab 3days <buffer>   <c-r>=substitute(system('date --date="+ 3 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab 4days <buffer>   <c-r>=substitute(system('date --date="+ 4 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab 5days <buffer>   <c-r>=substitute(system('date --date="+ 5 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab 6days <buffer>   <c-r>=substitute(system('date --date="+ 6 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab 7days <buffer>   <c-r>=substitute(system('date --date="+ 7 days"            +\(%m/%d\)'),"\\n","","")<cr>
iab nmon <buffer>    <c-r>=substitute(system('date --date="next monday"         +\(%m/%d\)'),"\\n","","")<cr>
iab ntue <buffer>    <c-r>=substitute(system('date --date="week tuesday"      +\(%m/%d\)'),"\\n","","")<cr>
iab nwed <buffer>    <c-r>=substitute(system('date --date="week wednesday"      +\(%m/%d\)'),"\\n","","")<cr>
iab eotw <buffer>    <c-r>=substitute(system('date --date="next friday"         +\(%m/%d\)'),"\\n","","")<cr>
iab eonw <buffer>    <c-r>=substitute(system('date --date="week friday"         +\(%m/%d\)'),"\\n","","")<cr>
iab 2weeks <buffer>  <c-r>=substitute(system('date --date="+ 14 days"           +\(%m/%d\)'),"\\n","","")<cr>
iab 3weeks <buffer>  <c-r>=substitute(system('date --date="+ 21 days"           +\(%m/%d\)'),"\\n","","")<cr>
iab 2months <buffer> <c-r>=substitute(system('date --date="+ 60 days"           +\(%m/%d\)'),"\\n","","")<cr>
iab 3months <buffer> <c-r>=substitute(system('date --date="+ 90 days"           +\(%m/%d\)'),"\\n","","")<cr>
iab eotm <buffer>    <c-r>=substitute(system('date --date="next month - 1 day"  +\(%m/%d\)'),"\\n","","")<cr>
iab eoty <buffer>    <c-r>=substitute(system('date --date="next year"           +\(%Y/%m/%d\)'),"\\n","","")<cr>


