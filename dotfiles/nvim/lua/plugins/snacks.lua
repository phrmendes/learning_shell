local snacks = require("snacks")

snacks.setup({
	indent = { enabled = true },
	input = { enabled = true },
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	words = { enabled = true },
	lazygit = { configure = false },
	statuscolumn = {
		enabled = true,
		git = { patterns = { "MiniDiffSign" } },
	},
})

_G.dd = function(...)
	snacks.debug.inspect(...)
end
_G.bt = function()
	snacks.debug.backtrace()
end

vim.print = _G.dd
