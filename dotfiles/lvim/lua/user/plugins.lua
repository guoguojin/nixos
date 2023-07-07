-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	"olexsmir/gopher.nvim",
	"leoluz/nvim-dap-go",
	"simrat39/rust-tools.nvim",
	{
		"saecki/crates.nvim",
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	-- python related plugins
	"ChristianChiarulli/swenv.nvim",
	"stevearc/dressing.nvim",
	"mfussenegger/nvim-dap-python",
	"nvim-neotest/neotest",
	"nvim-neotest/neotest-python",
	"tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  {
    "LhKipp/nvim-nu",
    config = function()
      require("nu").setup {
        use_lsp_features = true,
        all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']]
      }
    end,
  },
}
