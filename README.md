<a href="top"></a>

<p align="center">
<img src="https://raw.githubusercontent.com/b4b4r07/screenshots/master/vim-shellutils/logo.png">
</p>

<p align="center">
<b><a href="#vim-shellutils">About</a></b>
|
<b><a href="#description">Description</a></b>
|
<b><a href="#usage">Usage</a></b>
|
<b><a href="#installation">Installation</a></b>
|
<b><a href="#license">License</a></b>
</p>

<br>

vim-shellutils
===

[![](https://img.shields.io/travis/b4b4r07/vim-shellutils.svg?style=flat-square)][travis]
[![](https://img.shields.io/appveyor/ci/b4b4r07/vim-shellutils.svg?style=flat-square)][appveyor]
[![](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]

`vim-shellutils` is a simple, UNIX Shell commands (e.g., `/bin/ls`) emulator written in Vim script.

***DEMO:***

![vim-shellutils](https://raw.githubusercontent.com/b4b4r07/screenshots/master/vim-shellutils/demo.gif)

## Description

`vim-shellutils` is a simple Vim plugin that provides UNIX shell-like commands such as `rm`, `ls`, and so on. The fact that written in Vim script independently of the external command or other tools will bring numerous benefits to your Vim life. 

For example, when you want to run the command from the command line, it is troublesome to have to exit Vim. Thanks to this plugin, you can run the shell command without quit Vim. With further say, this fact shows that does not depend on the platform you want to run. Thus, it means that Windows is OK, too.

If only you had Vim and this plugin, you will be able to reproduce the shell command.

<p align="right"><a href="#top">:arrow_up:</a></p>

## Usage

- **What is the command you want to use?:** `ls`
- **Capitalize:** `Ls`
- **Run from the Vim command line:** `:Ls`
- Please `:h :Ls` if you have any questions


```vim
:Ls some_directory
```

Other commands that are available:

| Shell | Vim |
|---|---|
| `ls` | `:Ls` |
| `mv` | `:Mv` |
| `cp` | `:Cp` |
| `file` | `:File` |
| `cat` | `:Cat` |
| `head` | `:Head` |
| `tail` | `:Tail` |
| `touch` | `:Touch` |
| `mkdir` | `:Mkdir` |

For more usage and details, see [docmentation](./doc/vim-shellutils.txt).

<p align="right"><a href="#top">:arrow_up:</a></p>

## Advantage

Unlike a complete UNIX shell command, the command is emulated by `vim-shellutils` is optimized for Vim. In other words, the synopsis of the commands that are provided by this plugin band shell command is not the same at all. It is when the argument is less than the original. The emulated command interpret the current buffer as an argument in the automatic when the argument is omitted.

- Example (when you're editing the `~/.vimrc`):

	`:Cp ~/test` and `:Cp ~/.vimrc ~/test` are the same
	
	`:Rm ` and `:Rm ~/.vimrc` are the same

This means that it is possible to perform more easily shell command mock. Again, for more detailed description, please refer to the plugin's [help](./doc/vim-shellutils.txt).

<p align="right"><a href="#top">:arrow_up:</a></p>

## Installation

[Neobundle](https://github.com/Shougo/neobundle.vim) | [Vundle](https://github.com/VundleVim/Vundle.vim) | [vim-plug](https://github.com/junegunn/vim-plug)

```vim
NeoBundle 'b4b4r07/vim-shellutils'
Plugin    'b4b4r07/vim-shellutils'
Plug      'b4b4r07/vim-shellutils'
```

<p align="right"><a href="#top">:arrow_up:</a></p>

## Licence

[MIT][license] © [b4b4r07](http://b4b4r07.com)

[travis]: https://travis-ci.org/b4b4r07/vim-shellutils
[appveyor]: https://ci.appveyor.com/project/b4b4r07/vim-shellutils
[license]: https://raw.githubusercontent.com/b4b4r07/dotfiles/master/doc/LICENSE-MIT.txt

<p align="right"><a href="#top">:arrow_up:</a></p>
