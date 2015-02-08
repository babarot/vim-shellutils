" shellutils.vim

let s:save_cpo = &cpo
set cpo&vim

function! shellutils#ls(path, bang) "{{{1
  let path = empty(a:path) ? getcwd() : substitute(expand(a:path), '/$', '', 'g')
  if filereadable(path)
    call shellutils#file(path, '')
    return 1
  endif
  if !isdirectory(path)
    echohl ErrorMsg | echo path . ": No such file or directory" | echohl NONE
    return 0
  endif

  let save_ignore = &wildignore
  set wildignore=
  let filelist = glob(path . "/*")
  if !empty(a:bang)
    let filelist .= "\n".glob(path . "/.*[^.]")
  endif
  let &wildignore = save_ignore
  let filelist = substitute(filelist, '', '^M', 'g')

  if empty(filelist)
    echo "no file"
    return 0
  endif

  let lists = []
  for file in split(filelist, "\n")
    if isdirectory(file)
      call add(lists, fnamemodify(file, ":t") . "/")
    else
      if executable(file)
        call add(lists, fnamemodify(file, ":t") . "*")
      elseif getftype(file) == 'link'
        call add(lists, fnamemodify(file, ":t") . "@")
      else
        call add(lists, fnamemodify(file, ":t"))
      endif
    endif
  endfor

  echon "[" . len(lists) . "] "
  highlight LsDirectory  cterm=bold ctermfg=NONE ctermfg=26        gui=bold guifg=#0096FF   guibg=NONE
  highlight LsExecutable cterm=NONE ctermfg=NONE ctermfg=Green     gui=NONE guifg=Green     guibg=NONE
  highlight LsSymbolick  cterm=NONE ctermfg=NONE ctermfg=LightBlue gui=NONE guifg=LightBlue guibg=NONE

  for item in lists
    if item =~ '/'
      echohl LsDirectory | echon item[:-2] | echohl NONE
      echon item[-1:-1] . " "
    elseif item =~ '*'
      echohl LsExecutable | echon item[:-2] | echohl NONE
      echon item[-1:-1] . " "
    elseif item =~ '@'
      echohl LsSymbolick | echon item[:-2] | echohl NONE
      echon item[-1:-1] . " "
    else
      echon item . " "
    endif
  endfor
  return 1
endfunction

function! shellutils#file(file, bang) "{{{1
  let file = empty(a:file) ? expand('%') : a:file

  let ftype = getftype(file)
  let fpath = fnamemodify(file, ":p")
  let fname = simplify(file)
  let fsize = getfsize(file)
  let ftime = strftime("%Y-%m-%d %T", getftime(file))
  let fperm = getfperm(file)
  echon "[". ftype ."] "
  echon fperm . " "
  echon ftime . " "
  echon "("
  if ftype ==# 'dir'
    echon len(split(glob(fpath. "/*") . string(empty(a:bang) ? '' : glob(fpath . "/.*[^.]")), "\n"))
  else
    let size = fsize
    if size < 0
      let size = 0
    endif
    for unit in ['B', 'KB', 'MB']
      if size < 1024
        echon size . unit
        break
      endif
      let size = size / 1024
    endfor
  endif
  echon ") "
  echon fname

  return 1
endfunction

function! shellutils#cat(type, bang, ...) "{{{1
  for file in a:000
    " Black file
    if filereadable(file) && getfsize(file) == 0
      if !empty(a:bang) | continue | endif
      echohl WarningMsg | echo file . " is blank file" | echohl NONE
      continue
    endif
    " Directory
    if isdirectory(file)
      if !empty(a:bang) | continue | endif
      echohl WarningMsg | echo file . " is directory" | echohl NONE
      continue
    endif
    " No existing
    if !isdirectory(file) && !filereadable(file)
      if !empty(a:bang) | continue | endif
      echohl WarningMsg | echo file . " :No such file or directory" | echohl NONE
      continue
    endif

    for line in empty(a:type) ? readfile(file) : readfile(file, '', a:type)
      echo line == '' ? "\n" : line
    endfor
  endfor
endfunction

function! shellutils#mkdir(...) "{{{1
  let mkdired = []
  for dir in map(copy(a:000), 'expand(v:val)')
    try
      call mkdir(dir, 'p')
    catch /^Vim\%((\a\+)\)\=:E739/
      echohl WarningMsg
      echo printf('Mkdir: %s: File exists', dir)
      echohl None
      continue
    endtry
    call add(mkdired, dir)
  endfor
  if len(mkdired) >= 1
    echo "Make directory" string(mkdired) "successfully!"
    return 1
  endif
endfunction

function! shellutils#touch(...) "{{{1
  let touched = []
  for file in map(copy(a:000), 'expand(v:val)')
    if getftype(file) != ''
      echohl WarningMsg
      echo printf('Touch: %s: File exists', file)
      echohl None
      continue
    endif
    call writefile([], file)
    call add(touched, file)
  endfor
  if len(touched) >= 1
    echo "Make file" string(touched) "successfully!"
    return 1
  endif
endfunction

function! shellutils#cptool(mv, bang, ...) "{{{1
  let src = []
  let mv = a:mv ? 'mv' : 'cp'
  let bang = empty(a:bang) ? 1 : 0

  " Split the arguments into src and dest {{{2
  if a:0 == 1
    call add(src, expand('%'))
    let dst = expand(simplify(a:1))

  elseif a:0 == 2
    " If the src file is a directory.
    if !filereadable(expand(a:1))
      "echo printf("%s: %s: Is a directory", mv, a:1)
      echo printf("%s: %s: cannot read", mv, a:1)
      return 0
    endif

    call add(src, expand(simplify(a:1)))
    let dst = expand(simplify(a:2))

    " a:0 >= 3
  else
    " The last argument must be a directory.
    if !isdirectory(a:000[-1])
      echo printf("%s: target `%s' is not a directory", mv, a:000[-1])
      return 0
    endif

    for file in a:000[0:-2]
      if filereadable(file)
        call add(src, expand(simplify(file)))
      endif
    endfor
    let dst = expand(simplify(a:000[-1]))
  endif

  " Coping or moving {{{2
  let dst_success = []
  let reopen_stack = []
  for file in src
    " Get the pull path of a src file
    let src_file = fnamemodify(file, ':p')
    " If the dest is a directory or file.
    let dst_file = isdirectory(dst)
          \ ? substitute(fnamemodify(dst, ':p'), '/$', '', '') . '/' . fnamemodify(file, ':t')
          \ : fnamemodify(dst, ':p')

    " Overwrite?
    if filereadable(dst_file) && bang
      echo '"' . dst_file . '" is exists. Overwrite? [y/N]'
      if nr2char(getchar()) !=? 'y'
        echo 'Cancelled.'
        continue
      endif
    endif

    " Part to actually run
    if writefile(readfile(src_file, "b"), dst_file, "b") != 0
      echo 'cp miss!'
      continue
    else
      call add(dst_success, fnamemodify(dst_file, ':.:~'))
      " Delete the file and wipeout from a buffer-list, if has a:mv
      if a:mv
        call delete(src_file)
        if bufexists(file) && buflisted(file)
          execute 'bwipeout' bufnr(file)
          " Add reopen_stack
          call add(reopen_stack, dst_file)
        endif
      endif
    endif
  endfor
  "}}}2

  " Reopen
  if a:mv
    for file in reopen_stack
      execute 'silent edit' file
    endfor
  endif

  " Display the results when copying or moving one or more files.
  if len(dst_success) >= 1
    echo a:mv ? "Move" : "Copy" string(src) . " to " . string(dst_success) . " successfully!"
  endif
endfunction

function! shellutils#rm(bang, ...) "{{{1
  let files = []
  for file in a:0 ? map(copy(a:000), 'expand(v:val)') : split(simplify(expand('%:p')))
    if empty(a:bang)
      redraw | echo 'Delete "' . file . '"? [y/N]: '
    endif

    let file = fnamemodify(file, ":p")
    if !empty(a:bang) || nr2char(getchar()) ==? 'y'
      if isdirectory(file)
        "let l:tmp = "/tmp/shellutils_rm"
        "execute "cd" fnamemodify(l:tmp, ":h")
        "let dest = "shellutils_rm/" . fnamemodify(file, ":t")

        "let dest = "/tmp/".sha256(reltimestr(reltime()))[:7]
        let dest = "/tmp/".s:random_string(10)
        "if !isdirectory(dest)
        "  silent! call shellutils#mkdir(dest)
        "endif

        if rename(file, dest) == 0
          call add(files, file)
        else
          echo "This shellutils#rm does not support the removing directory."
        endif
      elseif filereadable(file)
        if delete(file) == 0
          call add(files, file)
          let bufname = bufname(fnamemodify(file, ':p'))
          if bufexists(bufname) && buflisted(bufname)
            execute "bwipeout" bufname
          endif
        endif
      else
        echohl WarningMsg | echo "The '" . file . "' does not exist" | echohl NONE
      endif
    endif
  endfor

  echo len(files) ? "Removed " . string(files) . "!" : "Removed nothing"
  return 1
endfunction

"__END__ {{{1

function! s:rand(n)
  " http://vim-users.jp/2009/11/hack98/
  let match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
  return reltimestr(reltime())[match_end : ] % (a:n + 1)
endfunction

function! s:random_string(n)
  let s = []
  let chars = split('0123456789abcdefghijklmnopqrstuvwxyz', '\ze')
  let max = len(chars) - 1
  for x in range(a:n)
    call add(s, (chars[s:rand(max)]))
  endfor
  let @+ = join(s, '')
  return join(s, '')
endfunction

function! shellutils#scope()
  return s:
endfunction

function! shellutils#sid()
  return maparg('<SID>', 'n')
endfunction
nnoremap <SID>  <SID>

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et fdm=marker ft=vim ts=2 sw=2 sts=2:
