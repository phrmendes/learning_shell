require("plugins.lsp.servers")
require("plugins.lsp.ltex")
require("plugins.lsp.linters")
require("plugins.lsp.formatters")
require("plugins.lsp.ui")

require("lsp_signature").setup()
require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
