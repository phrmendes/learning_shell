local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_signature = require("lsp_signature")
local lspconfig = require("lspconfig")
local neodev = require("neodev")
local lightbulb = require("nvim-lightbulb")

local fn = vim.fn
local map = vim.keymap.set

-- [[ capabilities ]] ---------------------------------------------------
local capabilities = cmp_nvim_lsp.default_capabilities()

-- [[ general servers configuration ]] ----------------------------------
local servers = {
	"ansiblels",
	"bashls",
	"dartls",
	"docker_compose_language_service",
	"dockerls",
	"helm_ls",
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

-- [[ specific servers configuration ]] ---------------------------------
lspconfig.jsonls.setup({
	capabilities = capabilities,
	cmd = { "vscode-json-languageserver", "--stdio" },
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
			completion = { callSnippet = "Replace" },
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
			workspace = {
				checkThirdParty = false,
				library = {
					[fn.expand("$VIMRUNTIME/lua")] = true,
					[fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- [[ neodev ]] ---------------------------------------------------------
neodev.setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- [[ LSP utils ]] ------------------------------------------------------
lsp_signature.setup()

-- diagnostic icons
local diagnostics_signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

for type, icon in pairs(diagnostics_signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- [[ code actions ]] ---------------------------------------------------
lightbulb.setup({
	autocmd = { enabled = true },
})

-- [[ keybindings ]] ----------------------------------------------------
local opts = { noremap = true, silent = true }

local description = function(desc)
	opts.desc = "LSP: " .. desc
end

description("go to references")
map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

description("go to declaration")
map("n", "gD", vim.lsp.buf.declaration, opts)

description("go to definitions")
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)

description("go to implementations")
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

description("go to type definitions")
map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)

description("code actions")
map({ "n", "x" }, "<Leader>a", vim.lsp.buf.code_action, opts)

description("document diagnostics")
map("n", "<Leader>dd", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

description("workspace diagnostics")
map("n", "<Leader>dw", "<cmd>Telescope diagnostics<cr>", opts)

description("show documentation for what is under cursor")
map("n", "<Leader>k", vim.lsp.buf.hover, opts)

description("rename symbol")
map("n", "<Leader>r", vim.lsp.buf.rename, opts)

description("document symbols")
map("n", "<Leader>s", "<cmd>Telescope lsp_document_symbols<cr>", opts)

description("workspace symbols")
map("n", "<Leader>S", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)