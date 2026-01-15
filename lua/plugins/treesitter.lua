return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- IMPORTANT: Treesitter must be on the RTP
    opts = {
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      },

      sync_install = false,
      auto_install = true,
      ignore_install = { "javascript" },

      highlight = {
        enable = true,
        disable = function(lang, buf)
          if lang == "c" or lang == "rust" then
            return true
          end

          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(
            vim.loop.fs_stat,
            vim.api.nvim_buf_get_name(buf)
          )
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}

