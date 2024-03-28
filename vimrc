" Map leader keys before everything
let mapleader = " "
let maplocalleader = " "

set autoindent
set breakindent

set termguicolors

set number
set relativenumber
set cursorline

set signcolumn=yes

set showcmd

set nostartofline

set ignorecase
set smartcase

set belloff=all
set encoding=utf-8
set hidden

set mouse=a
set clipboard=unnamedplus
set completeopt=menuone,noselect

set updatetime=100

" Keymaps
nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>

nnoremap <expr> <silent> k v:count == 0 ? "gk" : "k"
nnoremap <expr> <silent> j v:count == 0 ? "gj" : "j"

set background=dark

" Whichkey
" set timeoutlen=100
" nnoremap <silent> <leader> <CMD>WhichKey "<Space>"<CR>

" file tree
nnoremap <C-t> <CMD>Fern . -drawer -toggle -reveal=%<CR>

" comment
nnoremap <C-/> <CMD>Commentary<CR>
vnoremap <C-/> <CMD>Commentary<CR>

" Appearance

" colorscheme
colorscheme rosepine
" transparent
let disable_bg = 1
let disable_float_bg = 1
" lightline
function! NearestMethodOrFunction() abort
  return get(b:, "vista_nearest_method_or_function", "")
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:lightline = {
      \ "colorscheme": "rosepine",
      \ "active": {
      \   "left": [ [ "mode", "paste" ],
      \             [ "readonly", "filename", "modified", "method" ] ]
      \ },
      \ "component_function": {
      \   "method": "NearestMethodOrFunction"
      \ },
      \ }

let g:rainbow_active = 1

" Completion

" asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ "name": "tags",
    \ "allowlist": ["c"],
    \ "completor": function("asyncomplete#sources#tags#completor"),
    \ "config": {
    \    "max_file_size": 50000000,
    \  },
    \ }))
" ultisnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ "name": "ultisnips",
    \ "allowlist": ["*"],
    \ "completor": function("asyncomplete#sources#ultisnips#completor"),
    \ }))

" LSP
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists("+tagfunc") | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gD <plug>(lsp-peek-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gI <plug>(lsp-peek-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> gT <plug>(lsp-peek-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)
    nmap <buffer> <leader>cl <plug>(lsp-code-lens)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute("LspDocumentFormatSync")
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Search
nnoremap <leader>fb <CMD>Leaderf buffer<CR>
nnoremap <leader>ff <CMD>Leaderf file<CR>
nnoremap <leader>fg <CMD>Leaderf rg<CR>
nnoremap <leader>fl <CMD>Leaderf line<CR>

" Scheme
autocmd BufRead, BufNewFile *.scm set ft=scheme
autocmd BufRead, BufNewFile *.ss set ft=scheme
let g:slime_target = "vimterminal"
command SchemeTerminal rightbelow vertical terminal rlwrap gxi

autocmd BufRead,BufNewFile *.scm set tags+=/opt/gerbil/TAGS
autocmd BufRead,BufNewFile *.ss set tags+=/opt/gerbil/TAGS

let g:slime_no_mappings = 1
xmap <leader>s <plug>SlimeRegionSend
nmap <leader>s <plug>SlimeMotionSend
nmap <leader>ss <plug>SlimeLineSend

