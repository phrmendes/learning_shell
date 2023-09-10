local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_signature = require("lsp_signature")
local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")
local ltex_extra = require("ltex_extra")

-- lsp capabilities function
local capabilities = cmp_nvim_lsp.default_capabilities()

-- set up lsp_signature
lsp_signature.setup()

local diagnostics_signs = {
	Error = " ",
	Warn = " ",
	Hint = "󱍄 ",
	Info = " ",
}

for type, icon in pairs(diagnostics_signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- config language servers
local servers = {
	"ansiblels",
	"bashls",
	"dockerls",
	"metals",
	"nil_ls",
	"ruff_lsp",
	"taplo",
	"terraformls",
	"texlab",
	"yamlls",
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

-- special config for some language servers
lspconfig.marksman.setup({
	capabilities = capabilities,
	filetypes = { "markdown", "quarto" },
	root_dir = lspconfig_utils.root_pattern(".git", ".marksman.toml"),
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	cmd = { "vscode-json-languageserver", "--stdio" },
})

local language_id_mapping = {
	tex = "latex",
	quarto = "markdown",
	pandoc = "markdown",
}

ltex_extra.setup({
	load_langs = { "en", "pt", "pt-BR" },
	init_check = true,
	path = ".ltex",
	server_opts = {
		capabilities = capabilities,
		settings = {
			ltex = {
				filetypes = vim.tbl_keys(language_id_mapping),
				get_language_id = function(_, filetype)
					local language_id = language_id_mapping[filetype]
					if language_id then
						return language_id
					else
						return filetype
					end
				end,
				language = "auto",
				additionalRules = {
					enablePickyRules = true,
					motherTongue = "pt-BR",
				},
			},
		},
	},
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	settings = {
		single_file_support = true,
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "strict",
				useLibraryCodeForTypes = false,
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
				},
			},
		},
	},
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.efm.setup({
	capabilities = capabilities,
	filetypes = {
		"json",
		"lua",
		"nix",
		"python",
		"scala",
		"sh",
		"terraform",
		"toml",
		"yaml",
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
})
