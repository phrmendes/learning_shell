local utils = require("utils")

utils.config_diagnostics({ Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }, {
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "always",
		border = require("utils").borders.border,
	},
})

local servers = {
	ansiblels = {},
	basedpyright = {},
	bashls = {},
	cssls = {},
	dockerls = {},
	dotls = {},
	emmet_language_server = {},
	eslint = {},
	html = {},
	marksman = {},
	nil_ls = {},
	ruff = {},
	taplo = {},
	terraformls = {},
	denols = {},
	efm = require("plugins.lsp.efm"),
	elixirls = require("plugins.lsp.elixirls"),
	helm_ls = require("plugins.lsp.helm-ls"),
	jsonls = require("plugins.lsp.jsonls"),
	ltex_plus = require("plugins.lsp.ltex-plus"),
	lua_ls = require("plugins.lsp.lua-ls"),
	yamlls = require("plugins.lsp.yamlls"),
}

for key, value in pairs(servers) do
	utils.config_lsp_server({
		server = key,
		config = value,
	})
end
