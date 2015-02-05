runtime! plugin/shellutils.vim

call vspec#hint({'scope': 'shellutils#scope()', 'sid': 'shellutils#sid()'})

describe 'Mkdir'
  it '/tmp/test'
    let directory = '/tmp/test'
    call Call('shellutils#mkdir', directory)
    Expect isdirectory(directory) to_be_true
  end

  it '/tmp/spaced path'
    let directory = '/tmp/spaced path'
    call Call('shellutils#mkdir', directory)
    Expect isdirectory(directory) to_be_true
  end

  it 'already exists'
    let directory = '/tmp/test'
    Expect Call('shellutils#mkdir', directory) to_be_false
  end
end

describe 'Touch'
  it '/tmp/file'
    let file = '/tmp/file'
    call Call('shellutils#touch', file)
    Expect filereadable(file) to_be_true
  end

  it '/tmp/spaced file'
    let file = '/tmp/spaced file'
    call Call('shellutils#touch', file)
    Expect filereadable(file) to_be_true
  end
end

describe 'Ls'
  before
    Mkdir ~/ls_test
  end

  after
    Touch ~/ls_test/a
    Touch ~/ls_test/b
    Touch ~/ls_test/c
  end

  it 'Ls return'
    SKIP Expect Call('shellutils#ls', expand("~/ls_test"), '') to_be_true
  end

  it 'Ls output'
    redir => result
      call Call('shellutils#ls', expand("~/ls_test"), '')
    redir END

    let list_result = split(substitute(result, '  ', ' ', 'g'))

    echo "[DEBUG]".result
    echo "[DEBUG]".list_result
    Expect len(list_result) == 4
    Expect list_result == ["3:", "a", "b", "c"]
  end
end
