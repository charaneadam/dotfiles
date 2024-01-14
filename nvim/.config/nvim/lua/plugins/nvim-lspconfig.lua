return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
	
  {
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"texlab",
					"pyright",
					"clangd",
					"rust_analyzer",
				},
			})
		end,
	},

  {
    "neovim/nvim-lspconfig",
    config = function()

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      lspconfig = require('lspconfig')
      lspconfig.pyright.setup{
        capabilities = capabilities,
        on_attach = function()
          vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
          vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, {buffer=0})
          vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, {buffer=0})
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, {buffer=0})
          vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, {buffer=0})
          vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", {buffer=0})
        end,

        --[[settings = {]]
          --[[pylsp = {]]
            --[[plugins = {]]
              --[[yapf = { enabled = true },]]
              --[[pyflakes = { enabled = true },]]
              --[[rope = { enabled = true },]]
            --[[},]]
          --[[},]]
        --[[}]]

      }
    end
  }
}
