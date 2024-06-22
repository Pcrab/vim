vim9script

if system('uname -a | egrep [Mm]icrosoft') != ''
  if executable('win32yank.exe')
     const g:copy = 'win32yank.exe -i --crlf'
     const g:paste = 'win32yank.exe -o --lf'
  elseif exists('$DISPLAY') && executable('xclip')
     const g:copy = 'xclip -i -selection clipboard'
     const g:paste = 'xclip -o -selection clipboard'
  else
     const g:copy = 'clip.exe'
     const g:paste = 'powershell.exe Get-Clipboard'
  endif
  augroup myYank
    autocmd!
    autocmd TextYankPost * call system(g:copy, @")
  augroup END

  def Paste(mode: string): string
    setreg('"', system(g:paste))
    return mode
  enddef
  map <expr> p Paste('p')
  map <expr> P Paste('P')
else
  set clipboard=unnamedplus
endif

