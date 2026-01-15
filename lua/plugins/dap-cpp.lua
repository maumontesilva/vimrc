return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI setup
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- GDB adapter
      dap.adapters.gdb = {
        id = "gdb",
        type = "executable",
        command = "gdb",
        options = {
          detached = false,
        },
      }

      -- C / C++ configurations
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,
          pid = function()
            local name = vim.fn.input("Executable name (filter): ")
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",
          target = "localhost:1234",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- Auto open/close dap-ui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      { "<F5>",  function() require("dap").continue() end, desc = "DAP Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(
            vim.fn.input("Breakpoint condition: ")
          )
        end,
        desc = "DAP Conditional Breakpoint",
      },
    },
  },
}

