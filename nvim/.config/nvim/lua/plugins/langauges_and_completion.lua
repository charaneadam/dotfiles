return {
	-- 1. Mason & Automatic Installation
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()

			local mr = require("mason-registry")

			-- Refresh registry first (required on a fresh install with empty cache)
			mr.refresh(function()
				local packages = {
					-- LSP Servers
					"lua-language-server",
					"pyright",
					"clangd",
					"rust-analyzer",
					"texlab",
					"marksman",
					-- Formatters
					"stylua",
					"black",
					"latexindent",
					"bibtex-tidy",
					-- Linters
					"flake8",
				}

				for _, package in ipairs(packages) do
					local ok, p = pcall(mr.get_package, mr, package)
					if ok and not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},

	-- 2. LSP CONFIGURATION (Neovim 0.11 Native)
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason.nvim", "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "gf", function()
					require("conform").format({ bufnr = bufnr, async = true })
				end, opts)
			end

			-- Standard servers
			local servers = { "lua_ls", "pyright", "rust_analyzer", "texlab", "marksman" }
			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities, on_attach = on_attach })
				vim.lsp.enable(server)
			end

			-- Clangd: extra keybind + compile commands
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				on_attach = function(c, b)
					on_attach(c, b)
					vim.keymap.set("n", "gh", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = b })
				end,
				cmd = { "clangd", "--compile-commands-dir=build" },
			})
			vim.lsp.enable("clangd")
		end,
	},

  -- 3. COMPLETION using blink.cmp
	{
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
        { "kristijanhusak/vim-dadbod-completion", lazy = true },
    },
    opts = {
        keymap = { preset = "default" },
        sources = {
            default = { "lsp", "path", "buffer", "snippets" },
            per_filetype = {
                sql   = { "dadbod", "snippets", "buffer" },
            },
            providers = {
                dadbod = {
                    name   = "Dadbod",
                    module = "vim_dadbod_completion.blink",
                },
            },
        },
    },
},

	-- 4. FORMATTING with conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "black" },
					lua = { "stylua" },
					tex = { "latexindent" },
					bib = { "bibtex_tidy" },
					["_"] = { lsp_format = "fallback" },
				},
			})
		end,
	},

	-- 5. LINTING with nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "flake8" },
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- 6. TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"python",
					"rust",
					"latex",
					"c",
					"cpp",
					"markdown",
					"markdown_inline",
				},
				highlight = { enable = true },
				indent = { enable = false },
			})
		end,
	},
}
