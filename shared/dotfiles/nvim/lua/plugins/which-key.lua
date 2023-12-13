local wk = require("which-key")

wk.setup({
	plugins = { spelling = false },
	window = {
		border = "single",
	},
})

wk.register({
	mode = { "n", "v" },
	["gs"] = { name = "surround" },
	["<leader><space>"] = { name = "local leader" },
	["<leader><tab>"] = { name = "tabs" },
	["<leader>b"] = { name = "buffers" },
	["<leader>f"] = { name = "files/find" },
	["<leader>g"] = { name = "git" },
	["<leader>t"] = { name = "todo" },
})
