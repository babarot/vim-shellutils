vim-shellutils
====

**Overview**

Provides shell-like commands such as `'rm'`, `'ls'`, and so on from cmd-line.

## Description

The vim-shellutils provides shell-like commands such as `'rm'`, `'ls'`, and so on. This plugin is written in pure Vim script. This is because you can execute shell-like commands as long as you have huge Vim 7.3+. In addition, thanks to this plugin, you can execute it without exiting the Vim. If you want to make some direcotries, all you have to do is type `:Mkdir dirA dirB` from cmd-line.

![](http://cl.ly/image/391D0P3Q0t2x/vim-shellutils.gif)

## Requirement

Vim (**+Huge**) 7.3 or more

## Usage

### Ls

	:Ls[!] [{path}]
	
Show up some files in the {path} directory to cmd-line. If you want to show up all the files, including the files that begin with a dot in the {path} directory, then please put a bang. (`:Ls!`) If you omit the {path}, the current directory is specified as {path}.

### File

	:File [{path}]

Display {path} file information to cmd-line.If the {path} argument is omitted, set current buffer as {path}. The `:File` display many file information such as `'ls -l'` of shell. 

For example,
	
	[file] rw-r--r-- 2014-08-15 17:02:58 (5KB) shellutils.txt

### Rm

	:Rm[!] [{path}]


Remove the {path} file. If the {path} argument is omitted, remove the current buffer. The `:Rm` inquires whether you really delete the {path} file. If you don't do this, then please put a bang. (`:Rm!`)

### Mkdir

	:Mkdir {path}

Create the {path} directory(ies), if they do not already exist. Unlike 'mkdir' of shell, The `:Mkdir` always set '-p' option, thus create directory(ies) when parent directory if no existing.

### Touch

	:Touch {path}

Create blank files. Unlike that of the shell, do not edit its last modified time.

### Cat

	:Cat {path}

Concatenate FILE(s), to cmd-line.

### Head

	:Head {path}

Print the first 10 lines of each FILE to cmd-line. With no FILE, read current buffer.

### Tail

	:Tail {path}

Print the last 10 lines of each FILE to cmd-line. With no FILE, read current buffer.

### Cp

	:Cp[!] {src}    {dest}
	:Cp[!] {src}... {directory}

Copy {src} to {dest}, or multiple {src}s to {directory}. Prompt whether to overwrite existing regular destination files. If you don't do this, then please put a bang. (`:Cp!`)

### Mv

	:Mv[!] {src}    {dest}
	:Mv[!] {src}... {directory}

Rename {src} to {dest}, or move {src}s to {directory}. Prompt whether to overwrite existing regular destination files. If you don't do this, then please put a bang. (`:Mv!`)

*For more information, see also [help](./doc/vim-shelltils.txt)*

## Installation

### Manually

Put all files under `$VIM`.

### Pathogen (<https://github.com/tpope/vim-pathogen>)

Install with the following command.

	git clone https://github.com/b4b4r07/vim-shellutils ~/.vim/bundle/lightline.vim

### Vundle (<https://github.com/gmarik/Vundle.vim>)

Add the following configuration to your `.vimrc`.

	Plugin 'b4b4r07/vim-shellutils'

Install with `:PluginInstall`.

- See [Bundle interface change](https://github.com/gmarik/Vundle.vim/blob/v0.10.2/doc/vundle.txt#L372-L396).


### NeoBundle (<https://github.com/Shougo/neobundle.vim>)

Add the following configuration to your `.vimrc`.

	NeoBundle 'b4b4r07/vim-shellutils'

Install with `:NeoBundleInstall`.

## Licence

>The MIT License ([MIT](http://opensource.org/licenses/MIT))
>
>Copyright (c) 2014 b4b4r07
>
>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Author

| [![twitter/b4b4r07](http://www.gravatar.com/avatar/8238c3c0be55b887aa9d6d59bfefa504.png)](http://twitter.com/b4b4r07 "Follow @b4b4r07 on Twitter") |
|:---:|
| [b4b4r07](http://github.com/b4b4r07/ "b4b4r07 on GitHub") |

## See also

- [Help file](./doc/vim-shelltils.txt)
- [b4b4r07/vim-autocdls](https://github.com/b4b4r07/vim-autocdls)
