let s:suite = themis#suite('touch')
let s:assert = themis#helper('assert')

function! s:suite.touch_basically_check()
    let file = expand('~/touch_test')
    call s:assert.true(shellutils#touch(file))
endfunction

function! s:suite.touch_check_if_success()
    let file = expand('~/touch_test2')
    redir => result
        silent! call shellutils#touch(file)
    redir END

    call s:assert.match(result, "Make file")
endfunction

function! s:suite.touch_already_exists()
    let file = expand('~/touch_test')
    call s:assert.false(shellutils#touch(file))
endfunction

function! s:suite.touch_expand_path()
    call s:assert.true(shellutils#touch('~/touch_test3'))
    call s:assert.true(filereadable(expand('~/touch_test3')))
endfunction

function! s:suite.touch_file_is_blank()
    call s:assert.equals(getfsize(expand('~/touch_test')), 0)
endfunction
