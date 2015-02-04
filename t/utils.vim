runtime! plugin/shellutils.vim

call vspec#hint({'scope': 'shellutils#scope()', 'sid': 'shellutils#sid()'})

describe 'function test'
  it 'shellutils#mkdir'
    let directory = '/tmp/test'
    Expect Call('shellutils#mkdir', directory) == isdirectory(directory)
  end
end
