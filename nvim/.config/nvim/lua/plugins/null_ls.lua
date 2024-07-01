return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"flake8",
				"black",

				"codelldb",

				"lua_ls",
				"bibtex-tidy",
				"texlab",
				"latexindent",
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
				require("none-ls.diagnostics.flake8"),

        null_ls.builtins.formatting.bibclean,
				--require("none-ls.formatting.bibtex-tidy"),
				require("none-ls.formatting.latexindent"),

				null_ls.builtins.formatting.stylua,
			},
		})
	end,
}
