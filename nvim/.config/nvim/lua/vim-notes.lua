-- =============================================================================
-- NEOVIM MARKDOWN NOTES CONFIGURATION (TELESCOPE VERSION)
-- =============================================================================

local notes_dir = vim.fn.expand("~/Documents/notes")

-- -----------------------------------------------------------------------------
-- 1. Helper Functions
-- -----------------------------------------------------------------------------

-- Run ripgrep and populate the Quickfix list
local function get_tasks_to_qf(path)
	local cmd = string.format('rg --vimgrep "^- \\[ \\]" %s', path)
	local results = vim.fn.system(cmd)

	if results == "" then
		print("No undone tasks found in: " .. path)
		vim.cmd("cclose")
		return
	end

	vim.fn.setqflist({}, " ", { title = "Tasks: " .. path, lines = vim.split(results, "\n") })
	vim.cmd("copen")
end

-- -----------------------------------------------------------------------------
-- 2. Keybindings
-- -----------------------------------------------------------------------------

-- TOGGLE TASK: Swaps [ ] with [x]
vim.keymap.set("n", "<leader>x", function()
	local line = vim.api.nvim_get_current_line()
	if line:match("%- %[ %]") then
		line = line:gsub("%- %[ %]", "- [x]")
	elseif line:match("%- %[x%]") then
		line = line:gsub("%- %[x%]", "- [ ]")
	end
	vim.api.nvim_set_current_line(line)
end, { desc = "Toggle Markdown Task" })

-- GLOBAL TASKS: Search the entire vault
vim.keymap.set("n", "<leader>ta", function()
	get_tasks_to_qf(notes_dir)
end, { desc = "Search All Tasks" })

-- SMART PROJECT TASKS: Context-aware search
vim.keymap.set("n", "<leader>tp", function()
	local current_file_path = vim.fn.expand("%:p:h")

	if
		current_file_path:find(notes_dir, 1, true)
		and not current_file_path:find("daily", 1, true)
		and current_file_path ~= notes_dir
	then
		get_tasks_to_qf(current_file_path)
	else
		-- Use Telescope to pick a directory
		require("telescope.builtin").find_files({
			prompt_title = "Select Project Folder",
			cwd = notes_dir,
			find_command = {
				"find",
				".",
				"-maxdepth",
				"1",
				"-type",
				"d",
				"-not",
				"-path",
				"*/.*",
				"-not",
				"-name",
				"daily",
			},
			attach_mappings = function(prompt_bufnr, map)
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					get_tasks_to_qf(notes_dir .. "/" .. selection[1])
				end)
				return true
			end,
		})
	end
end, { desc = "Search Project Tasks" })

-- FUZZY FIND: Find files in vault
vim.keymap.set("n", "<leader>fn", function()
	require("telescope.builtin").find_files({ cwd = notes_dir })
end, { desc = "Find Note File" })

-- CONTENT SEARCH: Grep through note content
vim.keymap.set("n", "<leader>gn", function()
	require("telescope.builtin").live_grep({ cwd = notes_dir })
end, { desc = "Grep Note Content" })

-- QUICKFIX NAVIGATION
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next Task" })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous Task" })

-- -----------------------------------------------------------------------------
-- 3. Path Settings
-- -----------------------------------------------------------------------------
vim.opt.suffixesadd:append(".md")
vim.opt.path:append(notes_dir .. "/**")
