let s:suite = themis#suite('mkdir')
let s:assert = themis#helper('assert')

function! s:suite.mkdir_basically_check()
    let dir = expand('~/mkdir_test')
    call s:assert.true(shellutils#mkdir(dir))
endfunction

function! s:suite.mkdir_check_if_success()
    let dir = expand('~/mkdir_test2')
    redir => result
        silent! call shellutils#mkdir(dir)
    redir END

    call s:assert.match(result, "Make directory")
endfunction

function! s:suite.mkdir_already_exists()
    let dir = expand('~/mkdir_test')
    call s:assert.false(shellutils#mkdir(dir))
endfunction

function! s:suite.mkdir_expand_path()
    call s:assert.true(shellutils#mkdir('~/mkdir_test3'))
    call s:assert.true(isdirectory(expand('~/mkdir_test3')))
endfunction
