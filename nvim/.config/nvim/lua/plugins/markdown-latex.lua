return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			latex = {
				enabled = true,
				render_modes = false,
				converter = { "utftex", "latex2text" },
				highlight = "RenderMarkdownMath",
				position = "center",
				top_pad = 0,
				bottom_pad = 0,
			},
			completions = {
				lsp = { enabled = true },
			},
		},
	},
	{
		"lervag/vimtex",
		lazy = false, -- VimTeX recommends not lazy-loading for full functionality
		config = function()
			vim.g.vimtex_view_method = "zathura"
			-- Use latexmk with lualatex engine
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
				executable = "latexmk",
				engine = "-lualatex", -- This is the key part for Metropolis/Moloch
			}
		end,
	},
}
