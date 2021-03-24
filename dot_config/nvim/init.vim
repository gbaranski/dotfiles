call plug#begin()
" ========================================================================
" Support for languagues
" ========================================================================
Plug 'neovim/nvim-lspconfig' " NVIM Dev auto completion
Plug 'nvim-lua/completion-nvim' " Add auto competion
" ========================================================================

" ========================================================================
" File Navigation
" ========================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter' " improve syntax highlighting
Plug 'preservim/nerdtree'   " File navigation
" ========================================================================


" ========================================================================
" Misc
" ========================================================================
Plug 'jiangmiao/auto-pairs' " Automatic pairs
Plug 'tpope/vim-commentary' " add comments using gcc command 
Plug 'tpope/vim-surround' " parentheses, brackets, quotes, XML tags
" ========================================================================

" ========================================================================
" Tracking
" ========================================================================
Plug 'wakatime/vim-wakatime'
" ========================================================================

" ========================================================================
" External Applications
" ========================================================================
Plug 'christoomey/vim-tmux-navigator' " integration with tmux
" ========================================================================

" ========================================================================
" Appereance
" ========================================================================
" Plug 'joshdick/onedark.vim' " Theme
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'      " Theme
" ========================================================================

call plug#end()


" ========================================================================
" File navigation
" ========================================================================
nnoremap <C-t> :NERDTreeToggle<CR>

" Use ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files'
" Enable fuzzy finder
nnoremap <silent> <C-f> :Files<CR>
" ========================================================================


" ========================================================================
" LSP Autocompletion
" ========================================================================
set completeopt-=preview
autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWritePre *.go lua goimports(1000)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

" ========================================================================




" ========================================================================
" Apperance
" ========================================================================
syntax enable

" Onedark
" let g:onedark_termcolors = 256
" let g:onedark_terminal_italics = 1
" colorscheme onedark
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

set termguicolors
" Gruvbox
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_transparent_bg = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_hls_cursor = 'orange'
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'medium'
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_color_column = 'bg1'
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_invert_selection = 1
let g:gruvbox_invert_signs = 0
let g:gruvbox_invert_indent_guides = 1
let g:gruvbox_invert_tabline = 1
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 1
let g:gruvbox_guisp_fallback = 'NONE'
autocmd vimenter * ++nested colorscheme gruvbox


" ========================================================================


" ========================================================================
" Misc
" ========================================================================
nnoremap <Up> <Nop>
inoremap <Up> <Nop>
cnoremap <Up> <Nop>
vnoremap <Up> <Nop>

nnoremap <Left> <Nop>
inoremap <Left> <Nop>
cnoremap <Left> <Nop>
vnoremap <Left> <Nop>

nnoremap <Down> <Nop>
inoremap <Down> <Nop>
cnoremap <Down> <Nop>
vnoremap <Down> <Nop>

nnoremap <Right> <Nop>
vnoremap <Right> <Nop>
cnoremap <Right> <Nop>
inoremap <Right> <Nop>


" Fix sign column
set signcolumn=yes:1
set clipboard+=unnamedplus " Use system clipboard
set number relativenumber
set nu rnu
set noswapfile
set autoindent
set tabstop=2 shiftwidth=2 expandtab
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=1
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" ========================================================================



" ========================================================================
" LSP Configuration
" ========================================================================
lua << EOF
lspconfig = require "lspconfig"
completion = require "completion"
treesitter = require "nvim-treesitter.configs"

-- Setup treesitter
treesitter.setup {
  ensure_installed = "all",     
  highlight = {
    enable = true              
  },
}

local on_attach = function(client, bufnr)
  completion.on_attach(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

lspconfig.clangd.setup{
  on_attach = on_attach
}
lspconfig.rust_analyzer.setup{
  on_attach = on_attach
}
lspconfig.tsserver.setup{
  on_attach = on_attach
}
lspconfig.gopls.setup {
  cmd = {"gopls", "serve"},
  on_attach = on_attach
}
lspconfig.pyls.setup {
  on_attach = on_attach
}
lspconfig.hls.setup {
  on_attach = on_attach,
  filetypes = { "haskell", "lhaskell", "hs" }
}

function goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = "textDocument/codeAction"
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end

  vim.lsp.buf.formatting()
end
EOF
" ========================================================================
