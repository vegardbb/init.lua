local adapters = require('codecompanion.adapters')

return adapters.extend("ollama", {
	env = {
		url = "http://localhost:11434/",
		api_key = "OLLAMA_DEAFULT_KEY",
	},
	headers = {
		["Content-Type"] = "application/json",
		["Authorization"] = "Bearer ${api_key}",
	},
	parameters = {
		sync = true
	},
})