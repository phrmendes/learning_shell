local cmp = require("cmp")
local luasnip = require("luasnip")
local borders = require("utils").borders
local default_max_item_count = 5

require("cmp_pandoc").setup({
	crossref = { enable_nabla = true },
})

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<cr>"] = cmp.mapping({
			s = cmp.mapping.confirm({ select = true }),
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
		}),
		["<c-y>"] = cmp.mapping.complete(),
		["<c-u>"] = cmp.mapping.scroll_docs(-4),
		["<c-d>"] = cmp.mapping.scroll_docs(4),
		["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<bs>"] = cmp.mapping(function(fallback)
			cmp.abort()
			fallback()
		end, { "i", "s" }),
		["<c-l>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<c-h>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			ellipsis_char = "...",
			maxwidth = 50,
			mode = "symbol",
			symbol_map = {
				["vim-dadbod-completion"] = "",
				Copilot = "",
				otter = "🦦",
			},
		}),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "nvim_lsp_signature_help", max_item_count = default_max_item_count },
		{ name = "luasnip", max_item_count = default_max_item_count },
		{ name = "path", max_item_count = default_max_item_count },
		{ name = "emoji", max_item_count = default_max_item_count },
	}, {
		{ name = "copilot" },
		{ name = "buffer", max_item_count = default_max_item_count },
	}),
	window = {
		completion = borders,
		documentation = borders,
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	matching = { disallow_symbol_nonprefix_matching = false },
	sources = cmp.config.sources({
		{ name = "cmdline", max_item_count = default_max_item_count },
		{ name = "path", max_item_count = default_max_item_count },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer", max_item_count = default_max_item_count },
	},
})

cmp.setup.filetype("sql", {
	sources = cmp.config.sources({
		{ name = "vim-dadbod-completion" },
	}, {
		{ name = "buffer", max_item_count = default_max_item_count },
	}),
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap", max_item_count = default_max_item_count },
	},
})

cmp.setup.filetype({ "markdown", "quarto" }, {
	sources = cmp.config.sources({
		{ name = "cmp_pandoc", max_item_count = default_max_item_count },
		{ name = "cmp_zotcite", max_item_count = default_max_item_count },
		{ name = "luasnip", max_item_count = default_max_item_count },
		{ name = "latex_symbols", option = { strategy = 2 }, max_item_count = default_max_item_count },
		{ name = "path", max_item_count = default_max_item_count },
		{ name = "emoji", max_item_count = default_max_item_count },
	}, {
		{ name = "buffer", max_item_count = default_max_item_count },
	}),
})
