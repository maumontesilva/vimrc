return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Common on_attach
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      -- Go (gopls)
      vim.lsp.config("gopls", {
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      })

      -- C / C++ (clangd)
      vim.lsp.config("clangd", {
        on_attach = on_attach,
      })

      -- Enable servers
      vim.lsp.enable({
        "gopls",
        "clangd",
      })
    end,
  },
}

