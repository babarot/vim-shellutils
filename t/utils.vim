runtime! plugin/shellutils.vim

call vspec#hint({'scope': 'shellutils#scope()', 'sid': 'shellutils#sid()'})

describe 'function test'
  it 'shellutils#mkdir'
    let directory = '/tmp/test'
    call Call('shellutils#mkdir', directory)
    Expect isdirectory(directory) to_be_true
  end
end
