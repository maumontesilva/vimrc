return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
    },
    keys = {
      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview git hunk",
      },
      {
        "<leader>gi",
        function()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "Preview git hunk inline",
      },
      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Git blame line",
      },
      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Git diff this",
      },
      {
        "<leader>gt",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle git line blame",
      },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}

