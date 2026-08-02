--[[
This script loads your local .env file, which must be co-located with init.lua
--]]

local Path = require('plenary.path')

local path = Path:new(vim.fn.stdpath('config') .. '/.env')

if path:exists() then
	for _, line in ipairs(path:readlines()) do
		-- Skip comments and empty lines
		if not line:match("^%s*#") and line:match("=") then
			local name, value = line:match("^%s*(.-)%s*=%s*(.+)%s*$")
			if name and value then
				-- Remove optional surrounding quotes
				vim.env[name] = value:match('^"(.*)"$')
					or value:match("^'(.*)'$")
					or value
			end
		end
	end
end
