return {

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"flake8",
          "pylint",
          "black",

					"lua_ls",
					"texlab",
					"pyright",
					"clangd",
					"rust_analyzer",
				},
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {

          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.flake8,
           null_ls.builtins.diagnostics.pylint,

          null_ls.builtins.formatting.bibclean,
          null_ls.builtins.formatting.latexindent,

					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local keymaps = function()
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
					vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, { buffer = 0 })
					vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, { buffer = 0 })
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { buffer = 0 })
				end
			lspconfig = require("lspconfig")

			lspconfig.texlab.setup({
				capabilities = capabilities,
				on_attach = keymaps
			})


			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = keymaps
			})


			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = keymaps
			})


			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = keymaps
			})


			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = keymaps
			})

		end,
	},
}
