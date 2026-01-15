return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- ensure it loads before other UI plugins
    config = function()
      require("catppuccin").setup()
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "vim-airline/vim-airline",
  },

  {
    "vim-airline/vim-airline-themes",
    dependencies = { "vim-airline/vim-airline" },
  },

  {
    "ryanoasis/vim-devicons",
  },
}

