if system('uname -a | egrep [Mm]icrosoft') != ''
  let g:lastyank = 'y'
  if executable('win32yank.exe')
     let g:copy = 'win32yank.exe -i --crlf'
     let g:paste = 'win32yank.exe -o --lf'
  elseif exists('$DISPLAY') && executable('xclip')
     let g:copy = 'xclip -i -selection clipboard'
     let g:paste = 'xclip -o -selection clipboard'
  else
     let g:copy = 'clip.exe'
     let g:paste = 'powershell.exe Get-Clipboard'
  endif
  augroup myYank
    autocmd!
    autocmd TextYankPost * call system(g:copy, @")
  augroup END

  function! Paste(mode)
    if g:lastyank == 'y'
      let @" = system(g:paste)
    endif
    return a:mode
  endfunction
  map <expr> p Paste('p')
  map <expr> P Paste('P')
else
  set clipboard=unnamedplus
endif

