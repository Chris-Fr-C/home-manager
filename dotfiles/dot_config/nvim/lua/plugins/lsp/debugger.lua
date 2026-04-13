return {
  {

    "mfussenegger/nvim-dap",
  },
  -- And the language adapters
  -- https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- or better:
  -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Extensions#language-specific-extensions
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local dap = require("dap")
      local dap_py = require("dap-python")
      dap_py.setup("uv")
      dap_py.test_runner = "pytest"
      -- Keymaps
      --
      --
      vim.keymap.set("n", "<leader>d<Right>", dap.continue, { desc = "DAP: Continue", silent = true })
      vim.keymap.set("n", "<leader>d<Down>", dap.step_over, { desc = "DAP: Step Over", silent = true })
      vim.keymap.set("n", "<leader>d<Up>", dap.step_into, { desc = "DAP: Step Into", silent = true })
      vim.keymap.set("n", "<leader>d<Left>", dap.step_out, { desc = "DAP: Step Out", silent = true })

      -- Breakpoints
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint", silent = true })

      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Conditional Breakpoint", silent = true })
    end,
  },
  -- And a user interface
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dapui = require("dapui")
      local dap = require("dap")
      dapui.setup()
      -- nvim-dap-ui keymaps
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI: Toggle", silent = true })
      -- Win open close dapui
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
    end,
  },
}
