" shellutils.vim

if exists("g:loaded_shellutils")
  finish
endif
let g:loaded_shellutils = 1

let s:save_cpo = &cpo
set cpo&vim

" Commands: {{{1

" Do NOT overwritten the same name commands
"
" example:
"   let g:shellutils_disable_commands = ['Ls', 'Mkdir']
"
" By doing so, :Ls and :Mkdir commands in other plugin are used preferentially.
if !exists('g:shellutils_disable_commands')
  let g:shellutils_disable_commands = ['']
endif

let g:shellutils_shell_commands = [
      \ 'command! -nargs=+       -complete=dir  Mkdir call shellutils#mkdir(<f-args>)',
      \ 'command! -nargs=+       -complete=file Touch call shellutils#touch(<f-args>)',
      \ 'command! -nargs=+ -bang -complete=file Cp    call shellutils#cptool(0, <q-bang>, <f-args>)',
      \ 'command! -nargs=+ -bang -complete=file Mv    call shellutils#cptool(1, <q-bang>, <f-args>)',
      \ 'command! -nargs=+ -bang -complete=file Cat   call shellutils#cat("", <q-bang>, <f-args>)',
      \ 'command! -nargs=+ -bang -complete=file Head  call shellutils#cat(10, <q-bang>, <f-args>)',
      \ 'command! -nargs=+ -bang -complete=file Tail  call shellutils#cat(-10, <q-bang>, <f-args>)',
      \ 'command! -nargs=? -bang -complete=file Ls    call shellutils#ls(<q-args>, <q-bang>)',
      \ 'command! -nargs=? -bang -complete=file File  call shellutils#file(<q-args>, <q-bang>)',
      \ 'command! -nargs=* -bang -complete=file Rm    call shellutils#rm(<q-bang>, <f-args>)',
      \ ]

for commands in g:shellutils_shell_commands
  if match(g:shellutils_disable_commands, substitute(commands, '^.*\(\u\l\+\).*$', '\1', 'g')) == -1
    execute commands
  endif
endfor
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et fdm=marker ft=vim ts=2 sw=2 sts=2:
