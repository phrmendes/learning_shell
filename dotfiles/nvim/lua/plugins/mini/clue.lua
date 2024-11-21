local clue = require("mini.clue")

clue.setup({
	triggers = {
		{ mode = "n", keys = "<leader>" },
		{ mode = "x", keys = "<leader>" },
		{ mode = "n", keys = "<localleader>" },
		{ mode = "x", keys = "<localleader>" },
		{ mode = "n", keys = "<c-c>" },
		{ mode = "v", keys = "<c-c>" },
		{ mode = "n", keys = "<c-w>" },
		{ mode = "n", keys = "]" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
		{ mode = "n", keys = "'" },
		{ mode = "x", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "`" },
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
	},
	clues = {
		clue.gen_clues.builtin_completion(),
		clue.gen_clues.g(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers(),
		clue.gen_clues.windows(),
		clue.gen_clues.z(),
		{ mode = "n", keys = "<leader><tab>", desc = "Tabs" },
		{ mode = "n", keys = "<leader>b", desc = "Buffers" },
		{ mode = "n", keys = "<leader>c", desc = "Copilot" },
		{ mode = "x", keys = "<leader>c", desc = "Copilot" },
		{ mode = "n", keys = "<leader>g", desc = "Git" },
		{ mode = "x", keys = "<leader>g", desc = "Git" },
		{ mode = "n", keys = "<leader>o", desc = "Obsidian" },
		{ mode = "x", keys = "<leader>o", desc = "Obsidian" },
		{ mode = "n", keys = "<leader>t", desc = "Tests" },
	},
	window = {
		delay = 500,
		config = {
			width = "auto",
			border = require("utils").borders.border,
		},
	},
})
