local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filtetypes = { "go" } },
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gppls" })

local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup({
  command = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
})

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

local dap = require("dap")
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_path .. "bin/dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

-- Format on save
lvim.autocommands = {
  {
    "BufWritePre",
    {
      pattern = { "*.go" },
      command = "lua vim.lsp.buf.format()"
    }
  }
}

-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}",
--   },
--   {
--     type = "delve",
--     name = "Debug (go.mod)",
--     request = "launch",
--     program = "./${relativeFileDirname}",
--   },
--   {
--     type = "delve",
--     name = "Debug Test",
--     request = "launch",
--     mode = "test",
--     program = "${file}",
--   },
--   {
--     type = "delve",
--     name = "Debug Test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}",
--   },
-- }
