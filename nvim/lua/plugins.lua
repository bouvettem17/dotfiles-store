local status, packer = pcall(require, 'packer')
if not status then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'overcache/NeoSolarized'
  use 'folke/tokyonight.nvim'
  use 'kyazdani42/nvim-web-devicons' -- File Icons
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip' -- Snippet
  use 'hoob3rt/lualine.nvim' -- Status Line
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp for buffer words 
  use 'hrsh7th/cmp-nvim-lsp' -- nvim cmp source for nvim's built in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-tresitter.install').update({ with_sync = true }) end,
  }

  use 'mfussenegger/nvim-jdtls'

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'akinsho/nvim-bufferline.lua'
  use 'norcalli/nvim-colorizer.lua'

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  use 'folke/zen-mode.nvim'

  use 'sindrets/diffview.nvim'
end)
