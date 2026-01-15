return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      display = {
          chat = {
              window = {
                  layout = "vertical",
                  position = "right",
                  width = 80,
                  full_height = true,
                  opts = {
                      winfixwidth = true,
                  },
              },
          },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "mistral:7b-instruct",
              },
            },
          })
        end,
      },

      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
    },
    keys = { 
      { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" }, 
      { "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Toggle" }, 
      { "<leader>ci", "<cmd>CodeCompanionInline<cr>", desc = "CodeCompanion Inline" }, 
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" }, 
    }
  },
}
