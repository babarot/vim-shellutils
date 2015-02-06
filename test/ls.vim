let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_win = s:is_cygwin || s:is_windows
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \    (!executable('xdg-open') &&
      \    system('uname') =~? '^darwin'))

let s:suite = themis#suite('ls')
let s:assert = themis#helper('assert')

function! s:suite.ls_basically_check()
    let w = expand('~/ls_test')
    if !isdirectory(w)
        call mkdir(w)
    endif
    execute 'cd' w
    for f in ['a', 'b', 'c']
        call shellutils#touch(f)
    endfor

    call s:assert.true(shellutils#ls(w, ''))
    redir => result
        silent! call shellutils#ls(w, '')
    redir END

    let list_result = split(result, ' ')
    call s:assert.equals(len(list_result), 4)
    call s:assert.equals(list_result, ["[3]", "a", "b", "c"])
endfunction

function! s:suite.ls_spaced_filename()
    let w = expand('~/ls_test2')
    if !isdirectory(w)
        call mkdir(w)
    endif
    execute 'cd' w
    call shellutils#touch('spaced filename')

    call s:assert.true(shellutils#ls(w, ''))
    redir => result
        silent! call shellutils#ls(w, '')
    redir END

    let list_result = split(result, ' ')
    call s:assert.equals(len(list_result), 3)
    call s:assert.not_equals(list_result, ["[2]", "spaced", "filename"])
endfunction

function! s:suite.ls_non_existing()
    let res = shellutils#ls('~/non_existing', '')
    call s:assert.false(res)
endfunction

function! s:suite.ls_no_file()
    let w = expand('~/ls_test3')
    if !isdirectory(w)
        call mkdir(w)
    endif
    execute 'cd' w

    call s:assert.false(shellutils#ls(w, ''))
    redir => result
        silent! call shellutils#ls(w, '')
    redir END
    call s:assert.match(result, 'no file')
endfunction

function! s:suite.ls_bang()
    let w = expand('~/ls_test4')
    if !isdirectory(w)
        call mkdir(w)
    endif
    execute 'cd' w
    for f in ['a', 'b', 'c', '.d', '.e']
        call shellutils#touch(f)
    endfor

    call s:assert.true(shellutils#ls(w, '!'))
    redir => result
        silent! call shellutils#ls(w, '!')
    redir END

    let list_result = split(result, ' ')
    call s:assert.equals(len(list_result), 6)
    if s:is_win
        call s:assert.equals(list_result, ["[5]", "a", "b", "c", ".d*", ".e*"])
    else
        call s:assert.equals(list_result, ["[5]", "a", "b", "c", ".d", ".e"])
    endif
endfunction

function! s:suite.ls_file()
    let w = expand('~/ls_test5')
    if !isdirectory(w)
        call mkdir(w)
    endif
    execute 'cd' w
    call shellutils#touch('file')

    if s:is_win
        let f = w . '\file'
    else
        let f = w . '/file'
    endif
    call s:assert.true(shellutils#ls(f, ''))
    call s:assert.true(shellutils#file(f, ''))

    "redir => result
    "    call shellutils#ls(f, '')
    "redir END
    "call s:assert.match(substitute(result, '^  *', '', ''),
    "            \ 'rw-r--r-- ' . strftime("%Y-%m-%d %T", getftime(f)) . ' (0B) ' . f)
endfunction
