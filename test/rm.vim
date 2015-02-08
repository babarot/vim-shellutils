let s:suite = themis#suite('rm')
let s:assert = themis#helper('assert')
let s:file = expand('~/rm_test')

function! s:before_each()
    call shellutils#touch(s:file)
endfunction

function! s:suite.rm_basically_check()
    call s:assert.true(shellutils#rm('!', s:file))
endfunction

function! s:suite.rm_check_if_success()
    redir => result
        silent! call shellutils#rm('!', s:file)
    redir END
    call s:assert.match(result, "Removed")
endfunction

function! s:suite.rm_more_arguments()
    call shellutils#touch('~/rm_test.1', '~/rm_test.2', '~/rm_test.3')
    call s:assert.true(shellutils#rm('!', '~/rm_test.1', '~/rm_test.2', '~/rm_test.3'))
endfunction

function! s:suite.rm_if_no_argument()
    new
    w rm_test2
    call s:assert.equals(getfsize(expand('%')), 0)
    call shellutils#rm('!')
    call s:assert.equals(getfsize(expand('%')), -1)
endfunction

function! s:suite.rm_if_directory()
    ""call shellutils#mkdir('~/rm_test3')
    """call s:assert.true(!isdirectory('/tmp/shellutils_rm/rm_test3'))
    ""call shellutils#rm('!', '~/rm_test3')
    ""call s:assert.true(isdirectory('/tmp/shellutils_rm/rm_test3'))

    call shellutils#mkdir('~/rm_test')
    call s:assert.true(isdirectory(expand('~/rm_test')))
    redir => result
        silent! call shellutils#rm('!', '~/rm_test')
    redir END
    call s:assert.match(result, "Removed")
    call s:assert.true(!isdirectory(expand('~/rm_test')))
endfunction

""function! s:suite.rm_dir()
""    call shellutils#mkdir('~/dir')
""    "call s:assert.true(isdirectory(expand('~/dir')))
""    call s:assert.false(isdirectory('/tmp/shellutils_rm/dir'))
""
""    call shellutils#rm('!', '~/dir')
""    "call s:assert.false(isdirectory(expand('~/dir')))
""    call s:assert.true(isdirectory('/tmp/shellutils_rm/dir'))
""endfunction
""
""function! s:suite.rm_dir2()
""    call shellutils#mkdir('~/dir2')
""    "call s:assert.true(isdirectory(expand('~/dir2')))
""    call s:assert.false(isdirectory('/tmp/shellutils_rm/dir2'))
""
""    call shellutils#rm('!', '~/dir2')
""    "call s:assert.false(isdirectory(expand('~/dir2')))
""    call s:assert.true(isdirectory('/tmp/shellutils_rm/dir2'))
""endfunction
