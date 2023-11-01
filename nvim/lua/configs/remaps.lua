local telescope_builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {}) 
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, {}) 
vim.keymap.set('n', '<leader>fz', function()
    telescope_builtin.grep_string({search = vim.fn.input("Grep > ")});
end) 
