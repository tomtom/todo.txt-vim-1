" CopyTag: Searches for tags in todo.txt files
" Author: Graham Davies <graham@grahamdavies.net>
"         Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Revision:    36


if !exists('g:todotxt#dir')
    " Must end with a (back)slash.
    let g:todotxt#dir = ''   "{{{2
endif


if !exists('g:todotxt#files')
    let g:todotxt#files = ['todo.txt', 'done.txt']   "{{{2
endif


if !exists('g:todotxt#open')
    let g:todotxt#open = 'drop'   "{{{2
endif


if !exists('g:todotxt#date_md')
    let g:todotxt#date_md = '%m-%d'   "{{{2
endif


if !exists('g:todotxt#date_ymd')
    let g:todotxt#date_ymd = '%Y-%m-%d'   "{{{2
endif


function! todotxt#Open(basename) "{{{3
    if empty(g:todotxt#dir)
        throw 'todotxt: Please set g:todotxt#dir first'
    endif
    if g:todotxt#dir !~ '[\/]$'
        throw 'todotxt: g:todotxt#dir must end with a (back)slash'
    endif
    if empty(a:basename)
        if exists('g:loaded_tlib')
            let basename = tlib#input#List('s', 'Select file:', g:todotxt#files)
        else
            let list = []
            let idx = 0
            for f in g:todotxt#files
                call add(list, idx .' '. f)
                let idx += 1
            endfor
            let fi = inputlist(list)
            if fi >= 0 && fi < len(list)
                let basename = g:todotxt#files[fi]
            else
                let basename = ''
            endif
        endif
    else
        let basename = a:basename
    endif
    if !empty(basename)
        let filename = g:todotxt#dir . basename
        if !filereadable(filename)
            throw 'todotxt: todo.txt file not readable: '. filename
        endif
        exec g:todotxt#open fnameescape(filename)
    endif
endf


" Tags are defined as +noSpace and can be several +tag1 +tag2 +tag3
" Function should extract tag from surrounding text
" (10/01) +tag description
" should find +tag from above line
function! todotxt#CopyTag()
    let regex = '\(+\S\+\s\?\)\{1,}'
    let lineNum = line('.')
    let line = getline('.')
    let tagline = search(regex, 'cbn')
	if lineNum == tagline
		echo "Error: Line already has tag"
		return 
	endif
    let tagLineTxt = getline(tagline)
    let tag = matchstr(tagLineTxt,regex)
    let tag = substitute(tag,'\s\+$','','')
    execute "normal I" . tag . " "
endfunction


" Copy Date
function! todotxt#CopyDate()
    let regex = '(\d\+\/\d\+)'
    let lineNum = line('.')
    let line = getline('.')
    let tagline = search(regex, 'cbn')
	if lineNum == tagline
		echo "Error: Line already has tag"
		return 
	endif
    let tagLineTxt = getline(tagline)
    let tag = matchstr(tagLineTxt,regex)
    let tag = substitute(tag,'\s\+$','','')
    execute "normal I" . tag . " "
endfunction


" DueDate: Searches for tags in todo.txt files
" Author: Graham Davies <graham@grahamdavies.net>
"
" Allows you to enter :DueDate <args>
" Where <args> is the number of days before task is due
function! todotxt#DueDate(days)
    let when = 3600 * 24 * a:days
    " let yearDue = strftime("%Y", localtime() + when)
    " if yearDue != strftime("%Y", localtime())
        let format = g:todotxt#date_ymd
    " else
    "     let format = g:todotxt#date_md
    " endif
    let due = strftime(format, localtime() + when)
    let date_rx = substitute(format, '%\w', '\\d\\+', 'g')
    let due_rx = '\<due:'. date_rx .'\s\*'
    let line = getline(line('.'))
    if line =~ '\V'. due_rx
        exec 's/\V'. escape(due_rx, '/') .'/due:'. escape(due, '/\') .'/'
    else
        exec "norm! Idue:" . due . " "
    endif
endfunction


" DueNow: Searches for tasks that are due
function! todotxt#MarkDue()
    let pattern = '(\([01][0-9]\)\/\([0123][0-9]\))'
    let line    = search(pattern, 'wc')
    let dueDate = matchlist(getline(line),pattern)
    let dueMonth = dueDate[1]
    let dueDay  = dueDate[2]
    let nowMonth = strftime("%m", localtime())
    let nowDay   = strftime("%d", localtime())
    let nowYear  = strftime("%Y", localtime())
    echo getline(line)
    let due = ''
    if dueMonth < nowMonth 
        let due = 'yes'
        echo "omg"
    endif
    if dueMonth == nowMonth 
        if dueDay <= nowDay
            echo "due"
            let due = 'yes'
        endif
    endif
    if due == 'yes'
        let priority = "!A "
        " Check for existing priority
        let status = match(getline(line),priority)
        if status == -1
            execute "normal I" . priority
            echo "added"
        else
            echo "Already priority " . status
        endif
    endif
endfunction


" TodoDone: Completes a task according to todo.txt syntax
"
" Adds "x 2009-10-13 17:18 " to the start of a task to show completion
" Adding an argument gives number of days in the past when done
function! todotxt#TodoDone(...)
    let when = 3600 * 24 * a:0
    let format = "%Y-%m-%d %H:%M "
    let doneDate = strftime(format, localtime() - when)
    execute "normal I" . "x " . doneDate
endfunction                                   


" TodoCancelled: Cancel a task according to todo.txt syntax
"
" Adds "x @cancelled " to the start of a task to show completion
" Adding an argument gives number of days in the past when done
function! todotxt#TodoCancelled(...)
    execute "normal I" . "x @cancelled "
endfunction


