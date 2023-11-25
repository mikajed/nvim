vim.opt.mouse = "a"	-- enables mouse
vim.opt.clipboard = "unnamedplus"	-- copy/paste
vim.opt.swapfile = false
vim.opt.number = true	-- show line numbers
vim.opt.showmatch = true	-- highlight matching parenthesis
vim.opt.splitright = true	-- vertical split to the right
vim.opt.termguicolors = true	-- 24 bit RGB colors
vim.opt.expandtab = true	-- when true it uses spaces instead of tabs
vim.opt.shiftwidth = 4	-- shifts 4 spaces when tab
vim.opt.tabstop = 4
vim.opt.smartindent = true	--autoindent new lines
vim.opt.cursorline = true	-- show cursor line
vim.opt.wrap = false	-- no wrap
vim.opt.title = true	-- show title in terminal
vim.opt.background = "light"	-- bg color


-- lazy plugin manager --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins hier --
require("lazy").setup({
  {'Mofiqul/vscode.nvim'},
{
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
},
{
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
},
{
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recomended as each new version will have breaking changes
    opts={
        --Config goes here
    },
},
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
},
{
    'NvChad/nvim-colorizer.lua'
},
{
  'nvim-lualine/lualine.nvim'
}
})


vim.cmd.colorscheme('vscode')

-- LSP CONFIG --
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  }
})


-- configure treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require 'colorizer'.setup()
require('lualine').setup()
