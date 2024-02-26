return {
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

				"codelldb",

				"lua_ls",
				"texlab",
				"pyright",
				"clangd",
				"rust_analyzer",
				"lua-language-server",
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
}
