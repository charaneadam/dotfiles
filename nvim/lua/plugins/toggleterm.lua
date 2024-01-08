return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			on_open = function(_)
				vim.cmd("startinsert!")
			end,
		})
	end,
}
