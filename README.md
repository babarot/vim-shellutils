vim-shellutils
===

## Overview

`vim-shellutils` is a simple, UNIX Shell-like commands (e.g. `/bin/ls`) tool for run in a non-Unix environment (Windows ;-), written in Vim script only. 

***DEMO***

![vim-shellutils](./shellutils.gif "vim-shellutils")

## Description

`vim-shellutils` is a simple tool that provides UNIX shell-like commands such as `'rm'`, `'ls'`, and so on.
The fact that is written in Vim script only will bring you a lot of advantages. For example, if you run the shell command in light manner, you can perform processing as close as possible to the shell command without exiting Vim. With further say, this fact shows that does not depend on the platform you want to run. This means that Windows is OK.
If even Vim and `vim-shellutils`, it is possible to realize a shell command mock.

## Requirement

Vim 7.3 or more

## Usage

- **What is the command you want to use?:** `ls`
- **Let's capitalize:** `Ls`
- **Run from the Vim command line:** `:Ls`
- Please `:h :Ls` if you have any questions


```vim
:Ls some_file.vim
:Ls some_dir/
:Ls ~
```

Other commands that are available:

- `:Mv`
- `:Cp`
- `:Mkdir`
- ...

For more information, see also [help](./doc/vim-shellutils.txt).

## Installation

### Manually

Put all files under `$VIM`.

### Pathogen (<https://github.com/tpope/vim-pathogen>)

Install with the following command.

	git clone https://github.com/b4b4r07/vim-shellutils ~/.vim/bundle/vim-shellutils

### Vundle (<https://github.com/gmarik/Vundle.vim>)

Add the following configuration to your `.vimrc`.

	Plugin 'b4b4r07/vim-shellutils'

Install with `:PluginInstall`.

- NOTE: [Bundle interface change](https://github.com/gmarik/Vundle.vim/blob/v0.10.2/doc/vundle.txt#L372-L396).


### NeoBundle (<https://github.com/Shougo/neobundle.vim>)

Add the following configuration to your `.vimrc`.

	NeoBundle 'b4b4r07/vim-shellutils'

Install with `:NeoBundleInstall`.

## Licence

The MIT License ([MIT](http://opensource.org/licenses/MIT))

## Author

| [![twitter/b4b4r07](http://www.gravatar.com/avatar/8238c3c0be55b887aa9d6d59bfefa504.png)](http://twitter.com/b4b4r07 "@b4b4r07 on Twitter") |
|:---:|
| [b4b4r07](https://twitter.com/intent/follow?screen_name=b4b4r07 "Follow @b4b4r07 on Twitter") |

## See also

- [Help](./doc/vim-shelltils.txt)
- [b4b4r07/vim-autocdls](https://github.com/b4b4r07/vim-autocdls)
