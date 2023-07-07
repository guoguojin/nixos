require("user.lsp.languages.go")
require("user.lsp.languages.rust")
require("user.lsp.languages.python")

-- lvim.lsp.diagnostics.virtual_text = false
vim.diagnostic.config({ virtual_text = false })

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "shfmt", filetypes = { "sh", "zsh" } },
	{ command = "prettier", filetypes = { "css" } },
})
