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
end

describe 'Touch'
  it '/tmp/file'
    let file = '/tmp/test'
    call Call('shellutils#touch', file)
    Expect filereadable(file) to_be_true
  end

  it '/tmp/spaced file'
    let file = '/tmp/spaced file'
    call Call('shellutils#touch', file)
    Expect filereadable(file) to_be_true
  end
end
