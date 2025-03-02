return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb",
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		dap.configurations.c = dap.configurations.cpp

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<leader>dc", function()
			dap.continue()
		end)
		--vim.keymap.set('n', '<leader>ds', function() dap.step_over() end)
		vim.keymap.set("n", "<leader>di", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<leader>do", function()
			dap.step_out()
		end)
	end,
}
