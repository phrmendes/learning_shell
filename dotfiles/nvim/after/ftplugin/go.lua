local bufnr = vim.api.nvim_get_current_buf()

require("keymaps").dap(bufnr)
require("keymaps").go(bufnr)
require("keymaps").refactoring(bufnr)