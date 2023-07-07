M = {}
-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["g,"] = "g,zvzz"
lvim.keys.normal_mode["g;"] = "g;zvzz"

lvim.keys.normal_mode["<F4>"] = [[:lua require'dap'.terminate()<CR>]]
lvim.keys.normal_mode["<F5>"] = [[:lua require'dap'.continue()<CR>]]
lvim.keys.normal_mode["<F6>"] = [[:lua require'dap'.repl_open()<CR>]]
lvim.keys.normal_mode["<F9>"] = [[:lua require'dap'.toggle_breakpoint()<CR>]]
lvim.keys.normal_mode["<F10>"] = [[:lua require'dap'.step_over()<CR>]]
lvim.keys.normal_mode["<F11>"] = [[:lua require'dap'.step_into()<CR>]]
lvim.keys.normal_mode["<F12>"] = [[:lua require'dap'.step_out()<CR>]]

lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.insert_mode["<M-j>"] = "<ESC>:m .+1<CR>==gi"
lvim.keys.insert_mode["<M-k>"] = "<Esc>:m .-2<CR>==gi"

lvim.keys.visual_mode["<M-j>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<M-k>"] = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode["p"] = '"_dP'

lvim.builtin.which_key.mappings["D"] = {
  name = "Database",
  u = { "<cmd>DBUIToggle<CR>", "Toggle DB UI" },
  f = { "<cmd>DBUIFindBuffer<CR>", "DB Find Buffer" },
  r = { "<cmd>DBUIRenameBuffer<CR>", "DB Rename Buffer" },
  l = { "<cmd>DBUILastQueryInfo<CR>", "DB Last Query Info" },
}

return M
