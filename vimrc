vim9script

const mapleader = ' '
const maplocalleader = ' '

const data_dir = has('nvim') ? stdpath('data') .. '/site' : '~/.vim'

if empty(glob(data_dir .. '/autoload/plug.vim'))
  silent execute '!curl -fLo ' .. data_dir .. '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

# Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) > 0
  \| PlugInstall --sync | source $MYVIMRC
\| endif

def Source(source_file: string)
  const $__tmp_vim_full_source_file_name = data_dir .. '/' .. source_file
  source $__tmp_vim_full_source_file_name 
  unlet $__tmp_vim_full_source_file_name 
enddef

set number
set relativenumber
set mouse=a
set background=dark
set hlsearch
set termguicolors
set signcolumn=yes
set encoding=utf-8 
set ignorecase
set smartcase
set noshowmode

# clipboard
Source('clipboard.vim')

plug#begin()
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'

  # Color scheme
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  Plug 'voldikss/vim-floaterm'

  Plug 'github/copilot.vim'

  Plug 'cohama/lexima.vim'
plug#end()

silent! colorscheme gruvbox
const g:lightline = {
  colorscheme: 'gruvbox'
}

## Keymaps
noremap x "_x
noremap X "_X

nnoremap <Esc> <Cmd>nohls<CR>

# ## COC
const g:coc_global_extensions = [
  'coc-json',
  'coc-git',
  'coc-explorer',
  ]

nnoremap <C-b> <Cmd>CocCommand explorer<CR>

# # GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

# # Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

def ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
enddef
# Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
# Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
# Remap keys for applying code actions at the cursor position
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
# Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

## LeaderF
nnoremap <C-g> <Cmd>Leaderf rg<CR>
nnoremap <C-p> <Cmd>Leaderf file<CR>

## Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
const g:goyo_linenr = 1
nnoremap <leader>z <Cmd>Goyo<CR>

## Term
nnoremap <C-\> <Cmd>FloatermToggle<CR>
tnoremap <C-\> <Cmd>FloatermToggle<CR>
tnoremap <Esc><Esc> <C-\><C-n>

