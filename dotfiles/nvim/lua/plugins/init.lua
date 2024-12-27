local now, later = require("mini.deps").now, require("mini.deps").later

require("plugins.mini")

now(function()
	require("plugins.dadbod")
	require("plugins.snacks")
end)

later(function()
	require("plugins.completion")
	require("plugins.copilot")
	require("plugins.dap")
	require("plugins.image")
	require("plugins.lazydev")
	require("plugins.lsp")
	require("plugins.markdown")
	require("plugins.notes")
	require("plugins.quickfix")
	require("plugins.slime")
	require("plugins.smart-splits")
	require("plugins.todotxt")
	require("plugins.treesitter")
end)
