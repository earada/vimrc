-- Vim configuration
vim.opt.wrap = true                     -- Wrap long lines
vim.opt.ruler = true                    -- Show the line and column numbers under the cursor
vim.opt.showcmd = true                  -- Show (partial) command in status line
vim.opt.showmatch = true                -- Show the matching brackets
vim.opt.mouse = ''                      -- Disable mouse
vim.opt.hlsearch = true                 -- Highlight all search pattern matches
vim.opt.incsearch = true                -- Search while typing
vim.opt.number = true                   -- Show the line numbers
vim.opt.relativenumber = true           -- Show the numbers relatives to the current line
vim.opt.scrolloff = 5                   -- Show 5 lines off while scrolling
vim.opt.sidescrolloff = 5               -- Show 5 columns off  while side-scrolling
vim.opt.lazyredraw = true               -- Do not redraw screen in the middle of a macro
-- vim.opt.clipboard = 'unnamed'           -- System's clipboard
vim.opt.tabstop = 4                     -- A tab is 4 spaces
vim.opt.softtabstop = 4                 -- Also softabs
vim.opt.shiftwidth = 4                  -- 4 spaces on indenting
vim.opt.expandtab = true                -- Expand the tabs
vim.opt.autoindent = true               -- Always indent
vim.opt.textwidth = 88                  -- Width of 88 chars per line
vim.opt.listchars = { eol = '$' }       -- Show $ as end of line in list mode
vim.opt.formatoptions:append('cqron1')  -- How automatic formating is done

-- Syntax highlight
vim.opt.background = 'dark'
vim.cmd [[
highlight ColorColumn ctermbg=black

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

highlight Pmenu      ctermbg=grey ctermfg=black
highlight PmenuSel   cterm=bold,reverse ctermbg=black ctermfg=yellow
highlight PmenuSbar  ctermbg=blue
highlight PmenuThumb ctermfg=lightblue

au TermOpen * tnoremap <Esc> <c-\><c-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd FileType go set tabstop=4|set shiftwidth=4|set noexpandtab
]]

-- Disable providers and enable custom python
vim.g.loaded_python_provider = 0        -- Disable python2 support
vim.g.loaded_perl_provider = 0          -- Disable perl support
vim.g.python3_host_prog = '~/.pyenv/versions/neovim/bin/python'


-- My mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = false })  -- Vim default behavior
vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F6>', '<cmd>set list!<Bar>set list?<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F7>', '<cmd>lua vim.lsp.diagnostic.enable()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F8>', '<cmd>lua vim.lsp.diagnostic.disable()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F9>', '<cmd>!~/.pyenv/versions/neovim/bin/black %<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', { noremap = true })

-- Move lines up/down with Ctrl+[jk]
vim.api.nvim_set_keymap('n', '<C-j>', 'mz:m+<cr>`z', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', 'mz:m-2<cr>`z', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]], { noremap = true })
vim.api.nvim_set_keymap('v', '<C-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]], { noremap = true })

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
vim.call('plug#end')

-- Plugins mappings
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NERDTreeToggle<CR><C-w>=', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { noremap = true })

-- telescope
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-h>"] = "which_key"
      }
    },
    layout_config = {
      horizontal = { width = 0.9 }
    },
    path_display = { truncate = 1 }
  },
  pickers = {},
  extensions = {}
}
require('telescope').load_extension('fzy_native')

-- Fix nvim 0.8.0 background color issue
vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#FFFFFF"})

vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gr', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gB', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true, silent = true })

-- LspConfig
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  buf_set_keymap('n', 'g<space>', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<space>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Lsp Servers
local servers = { 'gopls', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
