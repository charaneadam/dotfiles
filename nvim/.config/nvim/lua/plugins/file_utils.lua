return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				on_open = function(_)
					vim.cmd("startinsert!")
				end,
			})
		end,
	},
	{
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.5",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
				vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			end,
		},

		{
			"nvim-telescope/telescope-ui-select.nvim",
			config = function()
				require("telescope").setup({
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown({}),
						},
					},
				})
				require("telescope").load_extension("ui-select")
			end,
		},
	},
}
