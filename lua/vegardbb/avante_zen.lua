--[[
This file is not a plugin, but rather a standalone program for NeoVim which
provides a ClaudeCode-like or Cursor Zen-like user experience.

Here is a handy alias to put in your shell config so that you won't have to
retype the entire command all the time to boot up NeoVim in Avante Zen mode:

# Neovim AI Code alias
alias avante-zen='nvim -c '\''lua require("vegardbb.avante_zen")'\'''
--]]

-- enter avante zen mode shortly after startup, safely
local callback = function()
	local ok, api = pcall(require, 'avante.api')
	if ok and api and type(api.zen_mode) == 'function' then
		api.zen_mode()
	end
end

vim.defer_fn(callback, 250)
