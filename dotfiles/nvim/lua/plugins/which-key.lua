local wk = require("which-key")

wk.setup({
	plugins = { spelling = false },
	window = {
		border = "rounded",
	},
	icons = {
		breadcrumb = ">",
		separator = "",
		group = "+",
	},
})
