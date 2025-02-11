return {
	"neovim/nvim-lspconfig",
	config = function()
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
			-- add any options here, or leave empty to use the default settings
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local keymaps = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
			vim.keymap.set("n", "gi", vim.lsp.buf.references, { buffer = 0 })
			vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { buffer = 0 })
			vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { buffer = 0 })
			vim.keymap.set("n", "gr", vim.lsp.buf.rename, { buffer = 0 })
			vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
			vim.keymap.set("n", "gh", ":ClangdSwitchSourceHeader<CR>", { buffer = 0 })

			vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { buffer = 0 })
		end

		local dap = require("dap")
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}

		lspconfig = require("lspconfig")
		lspconfig.texlab.setup({
			capabilities = capabilities,
			on_attach = keymaps,
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = keymaps,
			cmd = { "clangd", "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build" },
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = keymaps,
		})

		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = keymaps,
		})

		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = keymaps,
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = keymaps,
		})
	end,
}
