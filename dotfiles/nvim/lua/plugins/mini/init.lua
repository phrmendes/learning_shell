local now, later = require("mini.deps").now, require("mini.deps").later

now(function()
	require("plugins.mini.base16")
	require("plugins.mini.diff")
	require("plugins.mini.icons")
	require("plugins.mini.notify")
	require("plugins.mini.sessions")
	require("plugins.mini.starter")
	require("plugins.mini.statusline")
	require("plugins.mini.tabline")
end)

later(function()
	require("plugins.mini.ai")
	require("plugins.mini.align")
	require("plugins.mini.bracketed")
	require("plugins.mini.bufremove")
	require("plugins.mini.clue")
	require("plugins.mini.comment")
	require("plugins.mini.cursorword")
	require("plugins.mini.extra")
	require("plugins.mini.files")
	require("plugins.mini.git")
	require("plugins.mini.hipatterns")
	require("plugins.mini.indentscope")
	require("plugins.mini.jump")
	require("plugins.mini.jump2d")
	require("plugins.mini.move")
	require("plugins.mini.pairs")
	require("plugins.mini.splitjoin")
	require("plugins.mini.surround")
	require("plugins.mini.trailspace")
	require("plugins.mini.visits")
end)
