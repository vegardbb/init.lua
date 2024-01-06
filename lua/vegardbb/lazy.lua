vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

return require("lazy").setup({
	'nvim-treesitter/playground',
	'theprimeagen/harpoon',
	'theprimeagen/refactoring.nvim',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	'nvim-treesitter/nvim-treesitter-context',
	'folke/zen-mode.nvim',
	'github/copilot.vim',
	'eandrju/cellular-automaton.nvim',
	'laytan/cloak.nvim',
	'wbthomason/packer.nvim',
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		config = function(plugin) vim.cmd('colorscheme rose-pine') end
	},
	{
		"folke/trouble.nvim",
		config = function(plugin)
			require("trouble").setup { icons = false }
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = function(plugin)
			plugin.update({ with_sync = true })()
		end
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
	  		'williamboman/mason-lspconfig.nvim',

			-- Autocompletion
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',

			-- Snippets
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets'
		}
	}
})
