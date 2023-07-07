local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  C = {
    name = "Go",
    i = { "<cmd>GoInstallDeps<CR>", "Install Go Dependencies" },
    T = { "<cmd>GoMod tidy<CR>", "Tidy" },
    f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format" },
    a = { "<cmd>GoTestAdd<CR>", "Add Test" },
    A = { "<cmd>GoTestsAll<CR>", "Add All Tests" },
    e = { "<cmd>GoTestsExp<CR>", "Add Exported Tests" },
    g = { "<cmd>GoGenerate<CR>", "Go Generate" },
    G = { "<cmd>GoGenerate %<CR>", "Go Generate File" },
    c = { "<cmd>GoCmt<CR>", "Generate Comment" },
    t = { "<cmd>lua require('dap-go').debug_test()<CR>", "Debug Test" },
  },
}

which_key.register(mappings, opts)
