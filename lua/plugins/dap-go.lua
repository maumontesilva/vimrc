return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      {
        "leoluz/nvim-dap-go",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup UI and Go adapter
      dapui.setup()
      require("dap-go").setup()

      -- Automatically open/close DAP UI
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
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "DAP Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
    },
  },
}

