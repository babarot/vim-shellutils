let s:suite = themis#suite('ls')
let s:assert = themis#helper('assert')

function! s:suite.basically_check()
    let w = expand('~/ls_test')
    call mkdir(w)
    execute 'cd' w

    for f in ['a', 'b', 'c']
        call shellutils#touch(f)
    endfor

    redir => result
      silent! call shellutils#ls(w, '')
    redir END

    let list_result = split(result, ' ')
    call s:assert.equals(len(list_result), 4)
    call s:assert.equals(list_result, ["[3]", "a", "b", "c"])
endfunction

function! s:suite.ls_spaced_filename()
    let w = expand('~/ls_test2')
    call mkdir(w)
    execute 'cd' w

    call shellutils#touch('spaced filename')

    redir => result
      silent! call shellutils#ls(w, '')
    redir END

    let list_result = split(result, ' ')
    call s:assert.equals(len(list_result), 3)
    call s:assert.not_equals(list_result, ["[2]", "spaced", "filename"])
endfunction
