let mapleader=' '
let maplocalleader = ' '

let s:data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(s:data_dir . '/autoload/plug.vim'))

  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

function! Source(source_file)
  let $__tmp_vim_full_source_file_name = s:data_dir . '/' . a:source_file
  source $__tmp_vim_full_source_file_name 
  unlet $__tmp_vim_full_source_file_name 
endfunction

set number
set relativenumber
set mouse=a
set background=dark
set hlsearch
set termguicolors
set signcolumn=yes
set encoding=utf-8 

" clipboard
call Source('clipboard.vim')

call plug#begin()
  Plug 'tpope/vim-sensible'

  " Color scheme
  Plug 'morhetz/gruvbox'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
call plug#end()

silent! colorscheme gruvbox

"" Keymaps
noremap x "_x
noremap X "_X

nnoremap <Esc> <Cmd>nohls<CR>

"" COC
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-git',
  \ 'coc-explorer',
  \]

nnoremap <C-b> <Cmd>CocCommand explorer<CR>

"" LeaderF
nnoremap <C-g> <Cmd>LeaderF rg<CR>
nnoremap <C-p> <Cmd>Leaderf file<CR>
