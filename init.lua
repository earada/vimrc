-- Options (only the ones that differ from Neovim defaults)
vim.opt.showmatch = true                -- Show the matching brackets
vim.opt.mouse = ''                      -- Disable mouse
vim.opt.number = true                   -- Show the line numbers
vim.opt.relativenumber = true           -- Show the numbers relatives to the current line
vim.opt.scrolloff = 5                   -- Show 5 lines off while scrolling
vim.opt.sidescrolloff = 5               -- Show 5 columns off while side-scrolling
-- vim.opt.clipboard = 'unnamed'        -- System's clipboard
vim.opt.tabstop = 4                     -- A tab is 4 spaces
vim.opt.softtabstop = 4                 -- Also softabs
vim.opt.shiftwidth = 4                  -- 4 spaces on indenting
vim.opt.expandtab = true                -- Expand the tabs
vim.opt.textwidth = 88                  -- Width of 88 chars per line
vim.opt.listchars = { eol = '$' }       -- Show $ as end of line in list mode
vim.opt.formatoptions:append('cqron1')  -- How automatic formating is done
vim.opt.termguicolors = false

-- Syntax highlight
vim.cmd.colorscheme('vim')
vim.opt.background = 'dark'
vim.cmd [[
highlight ColorColumn ctermbg=black

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

highlight Pmenu      ctermbg=grey ctermfg=black
highlight PmenuSel   cterm=bold,reverse ctermbg=black ctermfg=yellow
highlight PmenuSbar  ctermbg=blue
highlight PmenuThumb ctermfg=lightblue
]]

-- Autocommands
local augroup = vim.api.nvim_create_augroup('user', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd('TermOpen', {
  group = augroup,
  callback = function(ev)
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = ev.buf })
  end,
})
autocmd('BufEnter', {
  group = augroup,
  callback = function()
    if vim.bo.buftype == 'terminal' then vim.cmd.startinsert() end
  end,
})
autocmd('FileType', {
  group = augroup,
  pattern = 'go',
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false
  end,
})
autocmd('FileType', {
  group = augroup,
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.fixendofline = true
  end,
})

-- Disable providers and enable custom python
vim.g.loaded_python_provider = 0        -- Disable python2 support
vim.g.loaded_perl_provider = 0          -- Disable perl support
vim.g.python3_host_prog = '~/.config/nvim/.venv/bin/python3'

-- My mappings
vim.g.mapleader = ' '
local map = vim.keymap.set

map('n', 'Y', 'yy')                                   -- Vim default behavior
map('n', '<leader>w', '<cmd>w<CR>')
map('n', '<leader>q', '<cmd>q<CR>')
map('n', '<F6>', '<cmd>set list! list?<CR>')
map('n', '<F7>', function() vim.diagnostic.enable() end)
map('n', '<F8>', function() vim.diagnostic.enable(false) end)
map('n', '<F9>', '<cmd>!~/.config/nvim/.venv/bin/black %<CR>')
map('n', '<leader>h', '<cmd>nohlsearch<CR>')

-- Move lines up/down with Ctrl+[jk]
map('n', '<C-j>', 'mz:m+<CR>`z')
map('n', '<C-k>', 'mz:m-2<CR>`z')
map('v', '<C-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]])
map('v', '<C-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]])

-- Plugins (lazy.nvim)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Keep the lockfile next to the real init.lua (this file may be a symlink)
local config_dir = vim.fn.fnamemodify(vim.fn.resolve(vim.env.MYVIMRC), ':h')

local function builtin(picker)
  return function() require('telescope.builtin')[picker]() end
end

require('lazy').setup({
  {
    'preservim/nerdtree',
    keys = { { '<C-n>', '<cmd>NERDTreeToggle<CR><C-w>=' } },
  },
  {
    'mbbill/undotree',
    keys = { { '<leader>u', '<cmd>UndotreeToggle<CR>' } },
  },
  {
    'neovim/nvim-lspconfig',
    -- Newer versions nag on every start under Neovim 0.10; unpin on 0.11+
    commit = vim.fn.has('nvim-0.11') == 0 and '32b6a64' or nil,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-k>'] = 'move_selection_previous',
              ['<C-j>'] = 'move_selection_next',
              ['<C-h>'] = 'which_key',
            },
          },
          layout_config = {
            horizontal = { width = 0.9 },
          },
          path_display = { truncate = 1 },
        },
      }
      require('telescope').load_extension('fzy_native')
      -- Fix nvim 0.8.0 background color issue
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#FFFFFF' })
    end,
    keys = {
      { '<leader>ff', builtin('find_files') },
      { '<leader>fg', builtin('live_grep') },
      { '<leader>fs', builtin('grep_string') },
      { '<leader>fb', builtin('buffers') },
      { '<leader>fh', builtin('help_tags') },
      { '<leader>gl', builtin('git_commits') },
      { '<leader>gr', builtin('git_bcommits') },
      { '<leader>gc', builtin('git_branches') },
      { '<leader>gB', builtin('git_status') },
    },
  },
}, {
  lockfile = config_dir .. '/lazy-lock.json',
  rocks = { enabled = false },
  change_detection = { notify = false },
})

-- LSP
-- Buffer-local mappings, applied whenever a server attaches.
-- Neovim already provides [d / ]d for diagnostics and K for hover.
autocmd('LspAttach', {
  group = augroup,
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gk', vim.lsp.buf.hover, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'ge', vim.diagnostic.open_float, opts)
    map('n', 'gr', builtin('lsp_references'), opts)
    map('n', 'g<space>', vim.lsp.buf.format, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})

local servers = {
  gopls = {},
  rust_analyzer = {},
  ts_ls = {},
  pyright = {
    -- Pyright runs on Node and dies with "Reached heap limit" on big projects
    cmd_env = { NODE_OPTIONS = '--max-old-space-size=4096' },
    -- Safety net when the project has no pyrightconfig.json of its own
    settings = {
      python = {
        analysis = {
          diagnosticMode = 'openFilesOnly',
          exclude = {
            '**/node_modules', '**/__pycache__', '**/.venv', '**/venv',
            '**/build', '**/dist',
          },
        },
      },
    },
  },
}

for _, cfg in pairs(servers) do
  cfg.flags = { debounce_text_changes = 150 }
end

if vim.lsp.config then
  -- Neovim >= 0.11: native config, nvim-lspconfig only provides the defaults
  for name, cfg in pairs(servers) do
    vim.lsp.config(name, cfg)
  end
  vim.lsp.enable(vim.tbl_keys(servers))
else
  -- Neovim 0.10
  local lspconfig = require('lspconfig')
  for name, cfg in pairs(servers) do
    lspconfig[name].setup(cfg)
  end
end
