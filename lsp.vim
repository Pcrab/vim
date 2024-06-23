vim9script

## LSP
const lspOpts = {autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

final lspServers = [
  {
    name: 'clang',
    filetype: ['c', 'cpp'],
    path: 'clangd',
    args: ['--background-index']
  },
  {
    name: 'tsserver',
    filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact'],
    path: 'typescript-language-server',
    args: ['--stdio']
  },
  {
    name: 'biome',
    filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json'],
    path: 'biome',
    args: ['lsp-proxy']
  },
]
autocmd User LspSetup call LspAddServer(lspServers)
## Completion
final vim_completion_options = {
  'snippet': {
    'enable': true,
  },
}
autocmd VimEnter * g:VimCompleteOptionsSet(vim_completion_options)

