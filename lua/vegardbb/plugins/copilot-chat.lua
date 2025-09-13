-- Prompt capabilities for CoPilot
-- see also.
-- {
-- 'olimorris/codecompanion.nvim',
-- opts = {},
-- dependencies = {
-- 'nvim-lua/plenary.nvim',
-- 'moevis/base64.nvim'
-- },
-- },

return {
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
}
