--[[ <-- For your information: this is how you write multi-line comments

Preliminary: git gud with lua

	If you are not already familiar with Lua, I recommend taking some time
	to read through a guide. One particular example which will only take
	you roughly 10 - 15 minutes:
	- https://learnxinyminutes.com/docs/lua/

	After understanding a bit more about Lua, you can use `:help lua-guide`
	as a reference for how Neovim integrates Lua.
	- :help lua-guide
	- Online version: https://neovim.io/doc/user/lua-guide.html

Recommended first step: run Tutor

	The very first thing you should do, if you are not already familiar with
	the Vim family, is to run the command `:Tutor` in Neovim.

	If you don't know what this means, type the following:
	- <escape key>
	- :
	- Tutor
	- <enter key>

	The Tutor will help you get familiar with the basics of Vim, including
	Vim motions, its different modes, how to save edited files, and how to
	quit out of NeoVim.

"Stop it, get some HELP"

	The next command you want to frequent is `:help`. This will open up a
	help window with some basic information about reading, navigating and
	searching the built-in help documentation. This should be the first place
	you go to look when you are stuck or confused about something.

	Please note that this configuration provides a custom keymap, "<space>sh"
	to [s]earch through the [h]elp documentation. This is especially useful
	when you are not exactly sure of what you are looking for.

	Throughout this configuration file, multiple `:help X` commands can be
	found in comments. These are documentation references for each relevant
	setting, plugin or feature in Neovim used in the config.

	There are several `:help X` comments scattered throughout this config file.
	These are hints about where to find more information about the relevant
	settings, plugins or Neovim features used by the configuration.

	NB: Look for comments that start like so.

	Throughout the file. These are for you, the reader, to help you understand
	what is happening. Feel free to delete them once you understand what you
	are doing. They should still serve as a guide for when you are first
	encountering a few different constructs in your Neovim config.

	If you experience any errors while trying to setup Neovim with this config,
	run `:checkhealth` to get more info.

Kindest regards,
 - Vegard
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
-- NB: Must happen before all other plugins are loaded
-- (otherwise, the wrong leader key will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.guicursor = '' -- unset cursor
vim.o.termguicolors = true
vim.o.nu = true -- show line numbers in front of each line
vim.o.relativenumber = true -- very useful when jumping with j and k
-- default indentation settings, may be overridden
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.softtabstop = 0 -- always indent with TAB
vim.o.smartindent = true
vim.o.wrap = false -- keep the long lines runnin'
vim.o.colorcolumn = '80' -- put a highlight at column 80
vim.o.swapfile = false -- no swap files
vim.o.background = 'dark' -- uses the theme modus vivendi
vim.opt.isfname:append '@-@' -- array operations still rely on the `opt` API

-- Clear highlights on search when pressing <Esc> in normal mode
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--	See `:help hlsearch` - these lines disable highlight search
vim.o.hlsearch = false
vim.o.incsearch = true

-- NB: Set this setting to false if you do not have a Nerd Font installed
-- and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NB: You can change these options as you wish!
--	For more options, you can see `:help option-list`

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--	Schedule the setting after `UiEnter` because it can increase startup-time.
--	Remove this option if you want your OS clipboard to remain independent.
--	See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the
-- search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep sign column on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 100

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--	See `:help 'list'`
--	and `:help 'listchars'`
--
--	Notice listchars is set using `vim.opt` instead of `vim.o`.
--	It is very similar to `vim.o` but offers an interface for
-- conveniently interacting with tables.
--	 See `:help lua-options`
--	 and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the
-- buffer (like `:q`), instead raise a dialog asking if you wish to save the
-- current file(s). See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--	See `:help vim.keymap.set()`

-- run prettier, black, etc
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

-- Open the file explorer
vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

-- Diagnostic keymaps
vim.keymap.set(
	'n',
	'<leader>q',
	vim.diagnostic.setloclist,
	{ desc = 'Open diagnostic [Q]uickfix list' }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit
-- easier for people to discover. Otherwise, you normally need to press
-- <C-\><C-n>, which is not what someone will guess
-- without a bit more experience.
--
-- NB: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(
	't',
	'<Esc><Esc>',
	'<C-\\><C-n>',
	{ desc = 'Exit terminal mode' }
)

-- To better practice your Vim motions, disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--	Use CTRL+<hjkl> to switch between windows
--
--	See `:help wincmd` for a list of all window commands
vim.keymap.set(
	'n',
	'<C-h>',
	'<C-w><C-h>',
	{ desc = 'Move focus to the left window' }
)
vim.keymap.set(
	'n',
	'<C-l>',
	'<C-w><C-l>',
	{ desc = 'Move focus to the right window' }
)
vim.keymap.set(
	'n',
	'<C-j>',
	'<C-w><C-j>',
	{ desc = 'Move focus to the lower window' }
)
vim.keymap.set(
	'n',
	'<C-k>',
	'<C-w><C-k>',
	{ desc = 'Move focus to the upper window' }
)

-- NB: Some terminals have colliding keymaps or are not able to send distinct
-- keycodes
--[[
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--]]

-- [[ Basic Autocommands ]]
--	See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup(
		'vegardbb-highlight-yank',
		{ clear = true }
	),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
-- for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	}
	error('Error cloning lazy.nvim:\n' .. out)
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins with Lazy ]]
--
--	To check the current status of your plugins, run
--		:Lazy
--
--	You can press `?` in this menu for help. Use `:q` to close the window
--
--	To update plugins you can run
--		:Lazy update
--
-- NB: Here is where you install your plugins.
require('lazy').setup({
	-- NB: Plugins can be added with a link
	-- (or for a github repo: 'owner/repo' link).
	'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

	-- NB: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to automatically pass options to a plugin's `setup()`
	-- function, forcing the plugin to be loaded.
	--

	-- Alternatively, use `config = function() ... end`
	-- for full control over the configuration.
	-- If you prefer to call `setup` explicitly, use:
	--		{
	--				'lewis6991/gitsigns.nvim',
	--				config = function()
	--						require('gitsigns').setup({
	--								-- Your gitsigns configuration here
	--						})
	--				end,
	--		}
	--
	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`.
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{
		-- Adds git related signs to the gutter,
		-- as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	-- NB: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as
	-- handle lazy loading plugins that do not need to be loaded
	-- immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--	event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded.
	-- Events can be normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `opts` key (recommended),
	-- the configuration runs after the plugin has been loaded
	-- as `require(MODULE).setup(opts)`.

	{ -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VimEnter', -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key
			-- this setting is independent of vim.o.timeoutlen
			delay = 0, -- milliseconds
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty
				-- table which will use the default which-key.nvim
				-- defined Nerd Font icons, otherwise define a string table
				keys = vim.g.have_nerd_font and {} or {
					Up = '<Up> ',
					Down = '<Down> ',
					Left = '<Left> ',
					Right = '<Right> ',
					C = '<C-…> ',
					M = '<M-…> ',
					D = '<D-…> ',
					S = '<S-…> ',
					CR = '<CR> ',
					Esc = '<Esc> ',
					ScrollWheelDown = '<ScrollWheelDown> ',
					ScrollWheelUp = '<ScrollWheelUp> ',
					NL = '<NL> ',
					BS = '<BS> ',
					Space = '<Space> ',
					Tab = '<Tab> ',
					F1 = '<F1>',
					F2 = '<F2>',
					F3 = '<F3>',
					F4 = '<F4>',
					F5 = '<F5>',
					F6 = '<F6>',
					F7 = '<F7>',
					F8 = '<F8>',
					F9 = '<F9>',
					F10 = '<F10>',
					F11 = '<F11>',
					F12 = '<F12>',
				},
			},

			-- Document existing key chains
			spec = {
				{ '<leader>s', group = '[S]earch' },
				{ '<leader>t', group = '[T]oggle' },
				{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
				{ '<leader>a', group = '[A]I', mode = { 'n', 'v' } },
			},
		},
	},

	-- NB: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies
	-- of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				-- If encountering errors, see telescope-fzf-native README
				-- for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is
				-- installed/updated. This is only run then, not every time
				-- Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin
				-- should be installed and loaded.
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different
			-- things that it can fuzzy find! It's more than just a
			-- "file finder", it can search many different aspects of Neovim,
			-- your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing
			-- something like:
			--	:Telescope help_tags
			--
			-- After running this command, a window will open up and you are
			-- able to type in the prompt window. You will see a list of
			-- `help_tags` options and a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--	- Insert mode: <c-/>
			--	- Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the
			-- current Telescope picker. This is really useful to discover
			-- what Telescope can do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require('telescope').setup {
				-- You can put your default mappings / updates / etc. in here
				--	All the info you are looking for is available in
				-- `:help telescope.setup()`
				--
				-- defaults = {
				--	 mappings = {
				--		 i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--	 },
				-- },
				-- pickers = {}
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			}

			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			-- See `:help telescope.builtin`
			local builtin = require 'telescope.builtin'
			vim.keymap.set(
				'n',
				'<leader>sh',
				builtin.help_tags,
				{ desc = '[S]earch [H]elp' }
			)
			vim.keymap.set(
				'n',
				'<leader>sk',
				builtin.keymaps,
				{ desc = '[S]earch [K]eymaps' }
			)
			vim.keymap.set(
				'n',
				'<leader>sf',
				builtin.find_files,
				{ desc = '[S]earch [F]iles' }
			)
			vim.keymap.set(
				'n',
				'<leader>ss',
				builtin.builtin,
				{ desc = '[S]earch [S]elect Telescope' }
			)
			vim.keymap.set(
				'n',
				'<leader>sw',
				builtin.grep_string,
				{ desc = '[S]earch current [W]ord' }
			)
			vim.keymap.set(
				'n',
				'<leader>sg',
				builtin.live_grep,
				{ desc = '[S]earch by [G]rep' }
			)
			vim.keymap.set(
				'n',
				'<leader>sd',
				builtin.diagnostics,
				{ desc = '[S]earch [D]iagnostics' }
			)
			vim.keymap.set(
				'n',
				'<leader>sr',
				builtin.resume,
				{ desc = '[S]earch [R]esume' }
			)
			vim.keymap.set(
				'n',
				'<leader>s.',
				builtin.oldfiles,
				{ desc = '[S]earch Recent Files ("." for repeat)' }
			)
			vim.keymap.set(
				'n',
				'<leader><leader>',
				builtin.buffers,
				{ desc = '[ ] Find existing buffers' }
			)

			-- Slightly advanced example of overriding
			-- default behavior and theme
			vim.keymap.set('n', '<leader>/', function()
				-- You can pass additional configuration to Telescope to
				-- change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(
					require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					}
				)
			end, { desc = '[/] Fuzzily search in current buffer' })

			-- It's also possible to pass additional configuration options.
			--	See `:help telescope.builtin.live_grep()`
			-- for information about particular keys
			vim.keymap.set('n', '<leader>s/', function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end, { desc = '[S]earch [/] in Open Files' })

			vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
			vim.keymap.set('n', '<leader>gf', builtin.git_files, {})

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set('n', '<leader>sn', function()
				builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end, { desc = '[S]earch [N]eovim files' })
		end,
	},

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config,
		-- runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		-- Main LSP Configuration
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Auto-install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents,
			-- so we need to set it up here.
			-- NB: `opts = {}` is the same as calling
			-- `require('mason').setup({})`
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			-- Useful status updates for LSP.
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			'saghen/blink.cmp',
		},
		config = function()
			--[[Brief aside: **What is LSP?**

			LSP is an initialism you've probably heard, but might not
			understand what it is. LSP stands for Language Server Protocol.
			It is a protocol that helps editors and language tooling
			communicate in a standardized fashion.

			In general, you have a "server" which is a tool built to understand
			a particular language (such as `gopls`, `lua_ls`, `rust_analyzer`,
			etc.). These Language Servers (sometimes called LSP servers, but
			that's kind of like 'ATM Machine') are standalone processes that
			communicate with some "client" - in this case, Neovim!

			LSP provides Neovim with features including, but not limited to:
			- Go to definition
			- Find references
			- Autocompletion
			- Symbol Search

			As such, Language Servers are external tools that must be installed
			separately from Neovim. This is where `mason` and related plugins
			come into play.

			If you're wondering about lsp vs treesitter, you can check out the
			elegantly composed help section, `:help lsp-vs-treesitter`

			This function gets run when an LSP attaches to a particular buffer.
			That is to say, every time a new file is opened that is associated
			with an lsp (for example, opening `main.rs` is associated with
			`rust_analyzer`) this function will be executed to configure the
			current buffer
			--]]
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup(
					'vegardbb-lsp-attach',
					{ clear = true }
				),
				callback = function(event)
					-- NB: Remember that Lua is a real programming language,
					-- and as such it is possible to define small helper and
					-- utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more
					-- easily define mappings specific for LSP related items.
					-- It auto-sets the mode, buffer and description each time.
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(
							mode,
							keys,
							func,
							{ buffer = event.buf, desc = 'LSP: ' .. desc }
						)
					end

					local builtin = require 'telescope.builtin'

					-- Rename the variable under your cursor.
					-- Most Language Servers support renaming across files
					map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

					-- Execute a code action, usually your cursor needs to be
					-- on top of an error or a suggestion from your LSP for
					-- this to activate.
					map(
						'gra',
						vim.lsp.buf.code_action,
						'[G]oto Code [A]ction',
						{ 'n', 'x' }
					)

					-- Find references for the word under your cursor.
					map('grr', builtin.lsp_references, '[G]oto [R]eferences')

					-- Jump to the implementation of the word under your
					-- cursor. Useful when your language has ways of declaring
					-- types without an actual implementation.
					map(
						'gri',
						builtin.lsp_implementations,
						'[G]oto [I]mplementation'
					)

					-- Jump to the definition of the word under your cursor.
					-- This is where a variable was first declared, or where a
					-- function is defined, etc. To jump back, press <C-t>.
					map('grd', builtin.lsp_definitions, '[G]oto [D]efinition')

					-- NB: This is not Goto Definition, this is
					-- Goto Declaration. For example, in C this would take you
					-- to the header.
					map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- Fuzzy find all the symbols in your current document.
					-- Symbols are things like variables, functions, types, etc
					map(
						'gO',
						builtin.lsp_document_symbols,
						'Open Document Symbols'
					)

					-- Fuzzy find all the symbols in your current workspace.
					-- Similar to document symbols, except searches over your
					-- entire project.
					map(
						'gW',
						builtin.lsp_dynamic_workspace_symbols,
						'Open Workspace Symbols'
					)

					-- Jump to the type of the word under your cursor. Useful
					-- when you're not sure what type a variable is and you
					-- want to see the definition of its *type*,
					-- not where it was *defined*.
					map(
						'grt',
						builtin.lsp_type_definitions,
						'[G]oto [T]ype Definition'
					)

					-- This function resolves a difference between
					-- neovim nightly (version 0.11) and stable (version 0.10)
					---@param client? vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in
					-- specific files
					---@return boolean
					local function client_supports_meth(client, method, bufnr)
						if not client then
							return false
						end
						if vim.fn.has 'nvim-0.11' == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(
								method,
								{ bufnr = bufnr }
							)
						end
					end

					-- The following two autocommands are used to highlight
					-- references of the word under your cursor when your
					-- cursor rests there for a little while. See
					-- `:help CursorHold` for information about when
					-- this is executed.
					--
					-- When you move your cursor, the highlights will be
					-- cleared (the second autocommand).
					local client =
						vim.lsp.get_client_by_id(event.data.client_id)
					local text_document_highlight =
						vim.lsp.protocol.Methods.textDocument_documentHighlight
					local client_supports_doc_highlight = client_supports_meth(
						client,
						text_document_highlight,
						event.buf
					)
					if client_supports_doc_highlight then
						local highlight_augroup = vim.api.nvim_create_augroup(
							'vegardbb-lsp-highlight',
							{ clear = false }
						)
						vim.api.nvim_create_autocmd({
							'CursorHold',
							'CursorHoldI',
						}, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({
							'CursorMoved',
							'CursorMovedI',
						}, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup(
								'vegardbb-lsp-detach',
								{ clear = true }
							),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds {
									group = 'vegardbb-lsp-highlight',
									buffer = event2.buf,
								}
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay
					-- hints in your code, if the language server you are using
					-- supports them
					--
					-- This may be unwanted, since they will
					-- displace some of your code
					local text_document_inlay_hint =
						vim.lsp.protocol.Methods.textDocument_inlayHint
					local client_supports_inlay_hint = client_supports_meth(
						client,
						text_document_inlay_hint,
						event.buf
					)
					if client_supports_inlay_hint then
						local function toggle_inlay_hint()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled {
									bufnr = event.buf,
								}
							)
						end
						map(
							'<leader>th',
							toggle_inlay_hint,
							'[T]oggle Inlay [H]ints'
						)
					end
				end,
			})

			---@function format(diagnostic)
			-- This function is used to format diagnostic messages
			-- This is useful for languages that have different severity levels
			-- and you want to display them differently.
			-- see :help vim.diagnostic.message_format for more information
			---@param diagnostic vim.Diagnostic
			---@return string
			local function format(diagnostic)
				local diagnostic_message = {
					[vim.diagnostic.severity.ERROR] = diagnostic.message,
					[vim.diagnostic.severity.WARN] = diagnostic.message,
					[vim.diagnostic.severity.INFO] = diagnostic.message,
					[vim.diagnostic.severity.HINT] = diagnostic.message,
				}
				return diagnostic_message[diagnostic.severity]
			end

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				} or {},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
					format = format,
				},
			}

			-- LSP servers and clients are able to communicate to each other
			-- what features they support. By default, Neovim doesn't support
			-- everything that is in the LSP specification. Adding blink.cmp
			-- and luasnip gives Neovim *more* capabilities. So, we create new
			-- LSP capabilities with blink.cmp, and then broadcast them
			-- to the servers.
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- Enabling language servers
			-- Feel free to add/remove any LSPs that you want here.
			-- They will automatically be installed.
			--
			--	Add any additional override configuration in the following
			-- tables. Available keys are:
			--	- cmd (table): Override the default command used to
			--		start the server
			--	- filetypes (table): Override the default list of associated
			--		filetypes for the server
			--	- capabilities (table): Override fields in capabilities.
			--		Can be used to disable certain LSP features.
			--	- settings (table): Override the default settings passed when
			--		initializing the server.
			-- For example, to see the options for `lua_ls`, you can go to:
			--		https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- pyright = {},
				gopls = {},
				rust_analyzer = {},
				ts_ls = {},
				-- ... etc. See `:help lspconfig-all` for a list of all of
				-- the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language
				-- plugins that can be useful:
				--		https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP will work just fine
				--

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							-- toggle below to ignore Lua_LS's noisy
							-- `missing-fields` warnings
							diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools
			-- and/or manually install other tools, you can run
			--	:Mason
			--
			-- You can press `g?` for help in this menu.
			--
			-- `mason` had to be setup earlier: to configure its options, see
			-- the `dependencies` table for `nvim-lspconfig` above.
			--
			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Used to format Lua code
			})
			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed,
			}

			require('mason-lspconfig').setup {
				ensure_installed = {}, -- explicitly set to an empty table
				-- installs are populated via `mason-tool-installer`
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly
						-- passed by the server configuration above. Useful
						-- when disabling certain features of an LSP (for
						-- example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend(
							'force',
							{},
							capabilities,
							server.capabilities or {}
						)
						require('lspconfig')[server_name].setup(server)
					end,
				},
			}
			vim.lsp.handlers['textDocument/publishDiagnostics'] = function(
				data,
				result,
				ctx
			)
				if result.diagnostics == nil then
					return
				end
				local idx = 1
				while idx <= #result.diagnostics do
					local entry = result.diagnostics[idx]
					if entry.code == 80001 then
						-- { message = "File is a CommonJS module;
						-- it may be converted to an ES module.", }
						table.remove(result.diagnostics, idx)
					else
						idx = idx + 1
					end
				end
				vim.lsp.diagnostic.on_publish_diagnostics(data, result, ctx)
			end
		end,
	},

	{ -- Autoformat
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>f',
				function()
					require('conform').format {
						async = true,
						lsp_format = 'fallback',
					}
				end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that
				-- don't have a well standardized coding style. You can add
				-- additional languages here or re-enable it for the
				-- disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = 'fallback',
					}
				end
			end,
			formatters_by_ft = {
				lua = { 'stylua' },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You may use 'stop_after_first' to run the first available
				-- formatter from the list
				[[--javascript = {
					"prettierd",
					"prettier",
					stop_after_first = true
				},--]],
			},
		},
	},

	{ -- Autocompletion
		'saghen/blink.cmp',
		event = 'VimEnter',
		version = '1.*',
		dependencies = {
			-- Snippet Engine
			{
				'L3MON4D3/LuaSnip',
				version = '2.*',
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					local no_make = vim.fn.has 'win32' == 1
						or vim.fn.executable 'make' == 0
					if no_make then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade
					-- snippets. See the README about individual
					-- language/framework/plugin snippets:
					-- https://github.com/rafamadriz/friendly-snippets
					-- {
					--	 'rafamadriz/friendly-snippets',
					--	 config = function()
					--		 require('luasnip.loaders.from_vscode').lazy_load()
					--	 end,
					-- },
				},
				opts = {},
			},
			'folke/lazydev.nvim',
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			-- Tip: for other, more advanced Luasnip keymaps
			-- (e.g. selecting choice nodes, expansion) see:
			-- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			keymap = {
				-- 'default' (recommended) for mappings similar to built-in
				-- completions: <c-y> to accept ([y]es) the completion.
				--   This will auto-import if your LSP supports it. If the LSP
				--   sent a snippet, this will expand snippets.
				-- 'super-tab' for tab to accept
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- For an understanding of why the 'default' preset is
				-- recommended, see `:help ins-completion`
				--
				-- No, but seriously. Please do read `:help ins-completion`,
				-- it is a really good section of the manual!
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				preset = 'default',
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for
				-- 'Nerd Font'. The mono font adjusts spacing to ensure icons
				-- are aligned
				nerd_font_variant = 'mono',
			},

			completion = {
				-- By default, you may press `<c-space>` to show the
				-- documentation. Optionally, set `auto_show = true`
				-- to show the documentation after a delay.
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 500,
				},
			},

			sources = {
				default = { 'lsp', 'path', 'snippets', 'lazydev' },
				providers = {
					lazydev = {
						module = 'lazydev.integrations.blink',
						score_offset = 100,
					},
				},
			},

			snippets = { preset = 'luasnip' },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled
			--
			-- By default, we use the Lua implementation instead,
			-- but you may enable the rust implementation
			-- by setting the value to `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = 'lua' },

			-- Shows a signature help window
			-- while you type arguments for a function
			signature = { enabled = true },
		},
	},

	-- Pro tip: use the command `:Telescope colorscheme` to see
	-- which color schemes are already available
	{ -- You can easily change to a different colorscheme plugin.
		-- Edit the name of the colorscheme plugin below, and then
		-- edit the module reference in the config to whatever the name of that
		-- colorscheme is. In some cases, you may need to use the "name"
		-- setting if the repository name is different from the module name.
		'miikanissi/modus-themes.nvim',
		-- Makes sure to load in this before all the other plugins on startup.
		priority = 1000,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('modus-themes').setup {
				-- Set to 'deuteranopia' or 'tritanopia' for colorblind modes
				variant = 'default',
				styles = {
					-- Disable italics in comments and keywords
					comments = { italic = false },
					keywords = { italic = false },
				},
			}
			vim.cmd.colorscheme 'modus'
		end,
	},

	{
		'nmac427/guess-indent.nvim',
		config = function()
			require('guess-indent').setup {}
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false },
	},

	{ -- Collection of various small independent plugins/modules
		'echasnovski/mini.nvim',
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--	- va)	- [V]isually select [A]round [)]paren
			--	- yinq - [Y]ank [I]nside [N]ext [Q]uote
			--	- ci'	- [C]hange [I]nside [']quote
			require('mini.ai').setup { n_lines = 500 }

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'	 - [S]urround [D]elete [']quotes
			-- - sr)'	- [S]urround [R]eplace [)] [']
			require('mini.surround').setup()

			-- Simple and easy statusline.
			--	You could remove this setup call if you don't like it,
			--	and try some other statusline plugin
			local statusline = require 'mini.statusline'
			-- set use_icons to true if you have a Nerd Font
			statusline.setup { use_icons = vim.g.have_nerd_font }

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return '%2l:%-2v'
			end

			--See https://github.com/echasnovski/mini.nvim for more options
		end,
	},
	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		main = 'nvim-treesitter.configs', -- Sets main module to use for opts
		-- To configure Treesitter further, see `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				'bash',
				'c',
				'diff',
				'html',
				'lua',
				'luadoc',
				'markdown',
				'markdown_inline',
				'query',
				'vim',
				'vimdoc',
			},
			-- Autoinstall languages that are not already installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system
				-- (such as Ruby) for indent rules.
				-- If you are experiencing odd indenting issues, add the
				-- language to the list of additional_vim_regex_highlighting
				-- and disabled languages for indent.
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
		},
		-- There are additional nvim-treesitter modules that you may use to
		-- interact with nvim-treesitter. You should go explore a few, and see
		-- what interests you:
		--	- Incremental selection:
		--		Included, see `:help nvim-treesitter-incremental-selection-mod`
		--	- Show your current context:
		--		https://github.com/nvim-treesitter/nvim-treesitter-context
		--	- Treesitter + textobjects:
		--		https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},
	{
		-- Cloak is a plugin that hides secret environment variables in your
		-- code, such as API keys, passwords, etc. It does this by replacing
		-- the text with asterisks. You may toggle it on and off with a keymap.
		'laytan/cloak.nvim',
		config = function()
			require('cloak').setup {
				enabled = true,
				cloak_character = '*',
				-- The applied highlight group (colors) on the cloaking,
				-- see `:h highlight`.
				highlight_group = 'Comment',
				patterns = {
					{
						-- Match any file starting with ".env".
						-- This can be a table to match multiple file patterns.
						file_pattern = {
							'*.env*',
							'wrangler.toml',
							'.dev.vars',
						},
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- e.g cloak_pattern = { ":.+", "-.+" } for yaml files.
						cloak_pattern = '=.+',
					},
				},
			}
			vim.keymap.set('n', '<leader>cl', require('cloak').toggle)
		end,
	},
	{
		'tpope/vim-fugitive', -- run Git commands from within Neovim.
		config = function()
			-- use the `:G` command to open the fugitive status window.
			vim.keymap.set('n', '<leader>gs', ':G<CR>', {
				desc = '[G]it [S]tatus',
			})
			vim.keymap.set('n', '<leader>gi', ':G ', {
				desc = '[G]it command line [i]nterface',
			})
		end,
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim', -- Prompt for GitHub Copilot
		branch = 'main',
		cmd = 'CopilotChat',
		dependencies = { { 'nvim-lua/plenary.nvim', branch = 'master' } },
		opts = {
			window = { width = 0.4 },
			auto_insert_mode = true,
		},
		build = 'make tiktoken',
		keys = {
			{
				'<leader>as',
				'<CR>',
				ft = 'copilot-chat',
				desc = 'Submit Prompt',
				remap = true,
			},
			{
				'<leader>aa',
				function()
					return require('CopilotChat').toggle()
				end,
				desc = 'Toggle (CopilotChat)',
				mode = { 'n', 'v' },
			},
			{
				'<leader>ax',
				function()
					return require('CopilotChat').reset()
				end,
				desc = 'Clear (CopilotChat)',
				mode = { 'n', 'v' },
			},
			{
				'<leader>aq',
				function()
					vim.ui.input({
						prompt = 'Quick Chat: ',
					}, function(input)
						if input ~= '' then
							require('CopilotChat').ask(input)
						end
					end)
				end,
				desc = 'Quick Chat (CopilotChat)',
				mode = { 'n', 'v' },
			},
			{
				'<leader>ap',
				function()
					require('CopilotChat').select_prompt()
				end,
				desc = 'Prompt Actions (CopilotChat)',
				mode = { 'n', 'v' },
			},
		},
		config = function(_, opts)
			local chat = require 'CopilotChat'
			vim.api.nvim_create_autocmd('BufEnter', {
				pattern = 'copilot-chat',
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})
			chat.setup(opts)
		end,
	},

	-- The following comments will only work if you have cloned the entire
	-- repository, not just copy-pasted the contents of init.lua. If you want
	-- these files, they are in the repository, so you can simply download them
	-- and place them in the correct directories, as indicated by the require
	-- calls below.
	--
	-- NB: Next step on your Neovim journey: Add/configure additional plugins
	--
	-- Here are some example plugins that have been included in the repository.
	-- Uncomment any of the lines below to enable them
	-- (you will need to restart nvim for the changes to take effect)
	--
	-- require 'vegardbb.plugins.autopairs',
	-- require 'vegardbb.plugins.debug',
	-- require 'vegardbb.plugins.gitsigns', -- adds gitsigns recommend keymaps
	-- require 'vegardbb.plugins.indent_line',
	-- require 'vegardbb.plugins.lint',
	-- require 'vegardbb.plugins.neo-tree',

	-- NB: The import below can automatically add your own plugins,
	-- configuration, etc from `lua/custom/plugins/*.lua`. This is the easiest
	-- way to start modularizing your config.
	--
	-- Uncomment the following line and add your plugins to
	-- `lua/custom/plugins/*.lua` to get going.
	-- { import = 'custom.plugins' },
	--
	-- For additional information with loading, sourcing and examples,
	-- see `:help lazy.nvim-🔌-plugin-spec`
	-- Or you can use telescope! While in normal mode, type `<space>sh`,
	-- then type `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes your last
	-- telescope search
}, {
	ui = {
		-- Use the default lazy.nvim defined Nerd Font icons
		icons = vim.g.have_nerd_font and {} or {
			-- If not using a Nerd Font, define this unicode icons table below
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
